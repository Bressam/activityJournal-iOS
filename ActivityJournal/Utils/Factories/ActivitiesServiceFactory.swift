//
//  ActivitiesServiceFactory.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import Foundation

class ActivitiesServiceFactory {
    static var shared: ActivitiesServiceFactory = {
        return ActivitiesServiceFactory()
    }()
    
    private init() {}
    
    @MainActor
    func createActivitiesService(mocked useMockedProvider: Bool) -> ActivitiesService {
        let localProvider: ActivityDataProvider!
        if useMockedProvider {
            localProvider = ActivityDataProviderMock()
        } else {
            localProvider = LocalActivityDataProvider()
        }

        return .init(localDataProvider: localProvider)
    }
}
