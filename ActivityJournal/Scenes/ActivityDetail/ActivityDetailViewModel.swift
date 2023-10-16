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
    var activity: Activity
    
    init(activity: Activity) {
        self.activity = activity
    }
    
    func logActivity() {
        return activity.loggedData.append(.init())
    }
    
    func deleteActivity(at indexSet: IndexSet) {
        for index in indexSet {
            activity.loggedData.remove(at: index)
        }
    }
}
