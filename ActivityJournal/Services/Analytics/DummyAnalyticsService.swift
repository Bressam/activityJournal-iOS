//
//  DummyAnalyticsService.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 05/02/24.
//

import Foundation

class DummyAnalyticsService: AnalyticsService {
    func setup() {
        print("DummyAnalyticsService: Setup")
    }
    
    func logScreenEvent(screenName: String) {
        print("DummyAnalyticsService: Log screenName: \(screenName)")

    }
    
    func logCustomEvent(event: String, parameters: [String : Any]?) {
        print("DummyAnalyticsService: Log event: \(event), parameters: \(parameters ?? [:])")
    }
}
