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
    
    func getActivity(by id: PersistentIdentifier) -> Activity? {
        return activities.first(where: { $0.id == id })
    }
    
    
    // Lista de categorias [ActivityByCategory]
    // Cada categoria com lsita de graficos -> activitiesChartsData: [ActivityChartData]

    
    private func generateChartData() {
        var activitiesByCategory: [ActivityByCategory] = .init()

        for category in ActivityCategory.allCases {
            var activityCategoryData: ActivityByCategory = .init(category: category, activitiesChartsData: [])
            
            // Get current activity list of activities
            let currentCategoryActivities = activities.filter({ $0.category == category })
            
            // Prepare chart data of each activity from current category
            for currentCategoryActivity in currentCategoryActivities {
                let activityMonthlyLogData = getMonthlyChartData(from: currentCategoryActivity)
                let activityChartData: ActivityChartData = .init(id: currentCategoryActivity.id,
                                                                 title: currentCategoryActivity.title,
                                                                 category: category,
                                                                 monthlyData: activityMonthlyLogData,
                                                                 monthlyGoal: currentCategoryActivity.monthlyGoal)

                activityCategoryData.activitiesChartsData.append(activityChartData)
            }
            
            // Add only existing categories
            if !activityCategoryData.activitiesChartsData.isEmpty {
                activitiesByCategory.append(activityCategoryData)
            }
        }
        
        // Each Activity user created
//        for activity in activities {
//            
//        }
        
        // Notify listeners
        self.activitiesByCategory = activitiesByCategory
    }
    
    private func getMonthlyChartData(from activity: Activity) -> [MonthlyActivitiesData] {
        var chartMonthActivities: [MonthlyActivitiesData] = .init()
        
        // Group all logged data by month per year
        let loggedActivitiesByMonth = Dictionary(grouping: activity.loggedData, by: { $0.date.month })
        
        // For each month, append to chart data array
        for month in loggedActivitiesByMonth.keys {
            let monthDate = loggedActivitiesByMonth[month]!.first?.date.startOfMonth()
            chartMonthActivities.append(.init(activitiesCount: loggedActivitiesByMonth[month]?.count ?? 0, date: monthDate!))
        }
        
        return chartMonthActivities
    }
}
