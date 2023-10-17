//
//  ActivitiesService.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import Foundation

protocol ActivityDataProvider {
    func fetchActivities() -> [Activity]
    func createActivity() -> Activity
    func deleteActivity(at indexSet: IndexSet)
    func generateMockData()
}

class ActivitiesService: ActivityDataProvider {
    // MARK: - Properties
    private var localDataProvider: ActivityDataProvider
    
    // MARK: - Init & Setup
    init(localDataProvider: ActivityDataProvider) {
        self.localDataProvider = localDataProvider
    }

    // MARK: - Data operations
    func fetchActivities() -> [Activity] {
        return localDataProvider.fetchActivities()
    }
    
    func createActivity() -> Activity {
        return localDataProvider.createActivity()
    }
    
    func deleteActivity(at indexSet: IndexSet) {
        return localDataProvider.deleteActivity(at: indexSet)
    }
    
    // MARK: - Bootstrap | Mock generator
    func generateMockData() {
        localDataProvider.generateMockData()
    }
}
