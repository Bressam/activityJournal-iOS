//
//  ActivitiesListViewModel.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 15/10/23.
//

import Foundation
import SwiftData

class ActivitiesListViewModel: ObservableObject {
    // MARK: - Properties
    private let activitiesService: ActivitiesService
    @Published var activities: [Activity]
    
    
    // MARK: - Init
    init(activitiesService: ActivitiesService, activities: [Activity] = []) {
        self.activitiesService = activitiesService
        self.activities = activities
    }
    
    // MARK: - Data Handling
    func createActivity() -> Activity {
        let activity = activitiesService.createActivity()
        fetchActivities()
        return activity
    }
    
    func deleteActivity(at indexSet: IndexSet) {
        activitiesService.deleteActivity(at: indexSet)
        fetchActivities()
    }
    
    func fetchActivities() {
        activities = activitiesService.fetchActivities()
    }
    
    func generateMockData() {
        activitiesService.generateMockData()
        fetchActivities()
    }
}
