//
//  AnalyticsLogger.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 05/02/24.
//

import Foundation

protocol AnalyticsService {
    func setup()
    func logScreenEvent(screenName: String)
    func logCustomEvent(event: String, parameters: [String : Any]?)
}
