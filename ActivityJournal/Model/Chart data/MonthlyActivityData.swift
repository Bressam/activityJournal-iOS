//
//  MonthlyActivityData.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import Foundation

struct MonthlyActivitiesData: Identifiable {
    var id = UUID()
    let activitiesCount: Int
    let date: Date
}
