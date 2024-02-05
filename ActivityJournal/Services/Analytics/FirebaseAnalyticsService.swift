//
//  FirebaseAnalyticsService.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 05/02/24.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics

class FirebaseAnalyticsService: AnalyticsService {
    func setup() {
        FirebaseApp.configure()
    }

    func logScreenEvent(screenName: String) {
        let params: [String: Any] = [
            AnalyticsParameterScreenName: screenName
        ]
        Analytics.logEvent(AnalyticsEventScreenView, parameters: params)
    }

    func logCustomEvent(event: String, parameters: [String : Any]?) {
        Analytics.logEvent(event, parameters: parameters)
    }
}
