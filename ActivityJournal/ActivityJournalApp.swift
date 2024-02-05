//
//  ActivityJournalApp.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 15/10/23.
//

import SwiftUI
import SwiftData

@main
struct ActivityJournalApp: App {
    // MARK: - AppDelegate. Swiftui handles its lifecycle when using property wrapper
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    // MARK: - Services
    let activitiesService: ActivitiesService
    let analyticsService: AnalyticsService

    var body: some Scene {
        WindowGroup {
            TabView {
                ActivitiesListView(viewModel: .init(activitiesService: activitiesService, analyticsService: analyticsService))
                    .tabItem { Label("List", systemImage: "mail.stack") }
                ActivitiesChartsView(viewModel: .init(activitiesService: activitiesService, analyticsService: analyticsService))
                    .tabItem { Label("Charts", systemImage: "chart.line.uptrend.xyaxis.circle") }
            }
        }
    }
    
    init() {
        // Services creation
        activitiesService = ActivitiesServiceFactory.shared.createActivitiesService(mocked: false)

        // Analytics
        analyticsService = AnalyticsServiceFactory.shared.createAnalyticsServiceFactory(config: .firebase)
        appDelegate.analyticsService = analyticsService
    }
}
