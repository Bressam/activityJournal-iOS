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
    
    func generateMockData() {
        // Activity categories
        let sportActivity = Activity(title: "Pratice Sports",  activityDescription: "Any sport counts!", category: .sport)
        let studyActivity = Activity(title: "Study",  activityDescription: "Any study activity counts!", category: .study)
        modelContext.insert(sportActivity)
        modelContext.insert(studyActivity)

        // Generate past day activity logs
        let currentDate = Date()
        let secondsPerDay: Double = 86400
        for dayCount in 0..<100 {
            let newPastDate = currentDate.addingTimeInterval(-(Double(dayCount) * secondsPerDay))
            sportActivity.loggedData.append(LoggedData(date: newPastDate, notes: "Dummy note \(dayCount)"))
            studyActivity.loggedData.append(LoggedData(date: newPastDate, notes: "Dummy note \(dayCount)"))
        }
        
        // Manually fetch
        fetchActivities()
    }
}
