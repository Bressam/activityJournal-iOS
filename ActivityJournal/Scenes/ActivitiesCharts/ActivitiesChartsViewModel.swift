//
//  ActivitiesChartsViewModel.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import Foundation
import SwiftData

class ActivitiesChartsViewModel: ObservableObject {
    private var activities: [Activity] = [] {
        didSet {
            generateChartData()
        }
    }
    @Published var activitiesByCategory: [ActivityByCategory] = []
    private var modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchActivities() {
        do {
            let descriptor = FetchDescriptor<Activity>(sortBy: [SortDescriptor(\.title)])
            activities = try modelContext.fetch(descriptor)
        } catch let error {
            print("Activities fetch failed. Error: \(error)")
        }
    }
    
    func getActivity(by category: ActivityCategory) -> Activity? {
        return activities.first(where: { $0.category == category })
    }
    
    private func generateChartData() {
        var activitiesByCategory: [ActivityByCategory] = .init()
        
        // Each Activity user created
        for activity in activities {
            var chartMonthActivities: [MonthlyActivitiesData] = .init()
            
            // Group all logged data by month per year
            let loggedActivitiesByMonth = Dictionary(grouping: activity.loggedData, by: { $0.date.month })
            
            // For each month, append to chart data array
            for month in loggedActivitiesByMonth.keys {
                let monthDate = loggedActivitiesByMonth[month]!.first?.date.startOfMonth()
                chartMonthActivities.append(.init(activitiesCount: loggedActivitiesByMonth[month]?.count ?? 0, date: monthDate!))
            }
            
            // Save to category
            activitiesByCategory.append(.init(category: activity.category, monthlyData: chartMonthActivities, monthlyGoal: activity.monthlyGoal))
        }
        
        // Notify listeners
        self.activitiesByCategory = activitiesByCategory
    }
}
