//
//  ActivityByCategory.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import Foundation

struct ActivityByCategory: Identifiable {
    let id = UUID()
    let category: ActivityCategory
    let monthlyData: [MonthlyActivitiesData]
    let monthlyGoal: Int?
}
