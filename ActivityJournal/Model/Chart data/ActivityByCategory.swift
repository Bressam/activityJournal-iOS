//
//  ActivityByCategory.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import Foundation
import SwiftData

struct ActivityByCategory: Identifiable {
    let id = UUID()
    let category: ActivityCategory
    var activitiesChartsData: [ActivityChartData]
}

struct ActivityChartData: Identifiable {
    let id: PersistentIdentifier
    let title: String
    let category: ActivityCategory
    let monthlyData: [MonthlyActivitiesData]
    let monthlyGoal: Int?
}
