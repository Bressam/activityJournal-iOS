//
//  ActivityDetailViewModel.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 15/10/23.
//

import Foundation
import SwiftData

@Observable
class ActivityDetailViewModel {
    // MARK: - Properties
    var analyticsService: AnalyticsService
    var activity: Activity
    
    // MARK: - Init
    init(activity: Activity, analyticsService: AnalyticsService) {
        self.activity = activity
        self.analyticsService = analyticsService
    }
    
    // MARK: - Data handling
    func logActivity() {
        activity.loggedData.append(.init())
    }
    
    func deleteActivity(at indexSet: IndexSet) {
        for index in indexSet {
            activity.sortedLoggedData.remove(at: index)
        }
    }
}

// MARK: - Analytics Service
extension ActivityDetailViewModel {
    func onViewAppear() {
        analyticsService.logScreenEvent(screenName: "activity_detail")
    }
}
