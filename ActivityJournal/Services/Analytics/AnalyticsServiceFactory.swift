//
//  AnalyticsServiceFactory.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 05/02/24.
//

import Foundation

enum AnalyticsServiceFactoryConfig {
    case firebase, amplitude, mixpane, mocked
}

class AnalyticsServiceFactory {
    static var shared: AnalyticsServiceFactory = {
        return AnalyticsServiceFactory()
    }()
    
    private init() {}
    
    func createAnalyticsServiceFactory(config: AnalyticsServiceFactoryConfig) -> AnalyticsService {
        switch config {
        case .mocked: return  createDummyMockedLogger()
        case .firebase: return createFirebaseAnalyticsLogger()
        default: fatalError("Config provided not set up at analytics service factory.")
        }
    }
    
    private func createFirebaseAnalyticsLogger() -> AnalyticsService {
        return FirebaseAnalyticsService()
    }
    
    private func createDummyMockedLogger() -> AnalyticsService {
        return DummyAnalyticsService()
    }
}
