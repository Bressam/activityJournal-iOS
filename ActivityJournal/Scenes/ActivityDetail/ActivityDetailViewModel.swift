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
    var activity: Activity
    
    // MARK: - Init
    init(activity: Activity) {
        self.activity = activity
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
