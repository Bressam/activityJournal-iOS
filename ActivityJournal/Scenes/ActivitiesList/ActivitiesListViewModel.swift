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
    private let analyticsService: AnalyticsService
    private let activitiesService: ActivitiesService
    @Published var activities: [Activity]
    
    
    // MARK: - Init
    init(activitiesService: ActivitiesService,
         analyticsService: AnalyticsService,
         activities: [Activity] = []) {
        self.activitiesService = activitiesService
        self.activities = activities
        self.analyticsService = analyticsService
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

    func getActivityDetailViewModel(activity: Activity) -> ActivityDetailViewModel {
        return .init(activity: activity, analyticsService: analyticsService)
    }
}

//MARK: - Analytics Service
extension ActivitiesListViewModel {
    func onViewAppear() {
        analyticsService.logScreenEvent(screenName: "activity_list")
    }

    func activityDetailRequired() {
        analyticsService.logCustomEvent(event: "activity_detail_required",
                                        parameters: [
                                            "origin" : "view_activitiesListView"
                                        ])
    }
}
