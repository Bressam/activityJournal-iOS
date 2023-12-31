//
//  ActivityDataProviderMock.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import Foundation
import SwiftData

/// Creates a transient database. So data will be stored only in memory and will not affect real database
class ActivityDataProviderMock: ActivityDataProvider {
    private var activities: [Activity] = []
    private var container: ModelContainer
    private var modelContext: ModelContext
    
    @MainActor
    init() {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Activity.self,
                                               configurations: configuration)
            self.container = container
        } catch let error {
            print("Failed to init mock database. Error: \(error)")
            fatalError("Failed to init mock database. Error: \(error)")
        }
        
        modelContext = container.mainContext
    }

    // MARK: - Data operations
    func fetchActivities() -> [Activity] {
        let descriptor = FetchDescriptor<Activity>(sortBy: [SortDescriptor(\.title)])
        let activities = try? modelContext.fetch(descriptor)
        return activities ?? []
    }
    
    func createActivity() -> Activity {
        let activity = Activity()
        modelContext.insert(activity)
        return activity
    }
    
    func deleteActivity(at indexSet: IndexSet) {
        let activities = fetchActivities()
        for index in indexSet {
            let activity = activities[index]
            modelContext.delete(activity)
        }
    }
    
    // MARK: - Bootstrap | Mock generator
    func generateMockData() {
        // Activity categories
        let sportActivity = Activity(title: "Go to the gym",  activityDescription: "Gym!", category: .sport, loggedData: .init())
        let sport2Activity = Activity(title: "Rock climbing",  activityDescription: "Go to rock climbing gym!", category: .sport)
        let studyActivity = Activity(title: "Study code",  activityDescription: "Learning new language!", category: .study)
        let study2Activity = Activity(title: "Study french",  activityDescription: "Learning new language!", category: .study)
        
        // Store on mock database
        modelContext.insert(sportActivity)
        modelContext.insert(sport2Activity)
        modelContext.insert(studyActivity)
        modelContext.insert(study2Activity)

        // Generate past day activity logs
        let currentDate = Date()
        let secondsPerDay: Double = 86400
        for dayCount in 0..<100 {
            let newPastDate = currentDate.addingTimeInterval(-(Double(dayCount) * secondsPerDay))
            sportActivity.loggedData.append(LoggedData(date: newPastDate, notes: "Dummy note \(dayCount)"))
            if dayCount % 2 == 0 {
                sport2Activity.loggedData.append(LoggedData(date: newPastDate, notes: "Dummy note \(dayCount)"))
            }
            if dayCount % 3 == 0 {
                studyActivity.loggedData.append(LoggedData(date: newPastDate, notes: "Dummy note \(dayCount)"))
            }
        }
    }
}
