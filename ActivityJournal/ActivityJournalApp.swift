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
    // MARK: - Services
    let activitiesService: ActivitiesService

    var body: some Scene {
        WindowGroup {
            TabView {
                ActivitiesListView(viewModel: .init(activitiesService: activitiesService))
                    .tabItem { Label("List", systemImage: "mail.stack") }
                ActivitiesChartsView(viewModel: .init(activitiesService: activitiesService))
                    .tabItem { Label("Charts", systemImage: "chart.line.uptrend.xyaxis.circle") }
            }
        }
    }
    
    init() {
        // Services creation
        activitiesService = ActivitiesServiceFactory.shared.createActivitiesService(mocked: false)
    }
}
