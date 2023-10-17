//
//  ActivityServiceTests.swift
//  ActivityServiceTests
//
//  Created by Giovanne Bressam on 15/10/23.
//

import XCTest
@testable import ActivityJournal

final class ActivityServiceTests: XCTestCase {
    var mockedStubService: ActivityDataProvider!
    
    // MARK: - Setup & Teardown
    @MainActor
    override func setUpWithError() throws {
        mockedStubService = ActivitiesServiceFactory.shared.createActivitiesService(mocked: true)
    }

    override func tearDownWithError() throws {
        mockedStubService = nil
    }

    // MARK: - Tests
    func testEmptyActivityDefaultCreation() throws {
        let stubActivity = mockedStubService.createActivity()

        XCTAssert(stubActivity.title.isEmpty)
        XCTAssert(stubActivity.category == .none)
        XCTAssert(stubActivity.loggedData.isEmpty)
    }
    
    func testActivityCreation() throws {
        _ = mockedStubService.createActivity()
        let activitiesCount = mockedStubService.fetchActivities().count
        
        XCTAssert(activitiesCount == 1)
    }
    
    func testActivityDeletion() {
        _ = mockedStubService.createActivity()
        mockedStubService.deleteActivity(at: .init(integer: 0))
        let activities = mockedStubService.fetchActivities()
        XCTAssert(activities.isEmpty)
    }
}
