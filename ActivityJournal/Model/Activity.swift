//
//  Activity.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 15/10/23.
//

import Foundation
import SwiftData

@Model
class Activity {
    var title: String
    var activityDescription: String
    var category: ActivityCategory

    @Relationship(deleteRule: .cascade)
    var loggedData: [LoggedData] = []
    
    @Transient
    var sortedLoggedData: [LoggedData] {
        get {
            return loggedData.sorted(by: { $0.date > $1.date })
        } set {
            loggedData = newValue
        }
    }
    
    init(title: String = "",
         activityDescription: String = "",
         category: ActivityCategory = .none,
         loggedData: [LoggedData] = []) {
        self.title = title
        self.activityDescription = activityDescription
        self.category = category
        self.loggedData = loggedData
    }
}

@Model
class LoggedData {
    var date: Date
    var notes: String
    
    init(date: Date = .init(), notes: String = "") {
        self.date = date
        self.notes = notes
    }
}
