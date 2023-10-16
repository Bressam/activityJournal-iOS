//
//  ActivitiesListViewModel.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 15/10/23.
//

import Foundation
import SwiftData

class ActivitiesListViewModel: ObservableObject {
    @Published var activities: [Activity]
    var modelContext: ModelContext
    
    init(activities: [Activity] = [], modelContext: ModelContext) {
        self.activities = activities
        self.modelContext = modelContext
    }
    
    func createActivity() -> Activity {
        let activity = Activity()
        modelContext.insert(activity)
        fetchActivities()
        return activity
    }
    
    func deleteActivity(at indexSet: IndexSet) {
        for index in indexSet {
            let activity = activities[index]
            modelContext.delete(activity)
        }
        fetchActivities()
    }
    
    func fetchActivities() {
        do {
            let descriptor = FetchDescriptor<Activity>(sortBy: [SortDescriptor(\.title)])
            activities = try modelContext.fetch(descriptor)
        } catch let error {
            print("Activities fetch failed. Error: \(error)")
        }
    }
}
