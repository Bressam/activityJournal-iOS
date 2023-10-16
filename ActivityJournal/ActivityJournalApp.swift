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
    let container: ModelContainer

    var body: some Scene {
        WindowGroup {
            TabView {
                ActivitiesListView(viewModel: .init(modelContext: container.mainContext))
                    .modelContext(container.mainContext)
                    .tabItem { Label("List", systemImage: "mail.stack") }
                ActivitiesChartsView(viewModel: .init(modelContext: container.mainContext))
                    .modelContext(container.mainContext)
                    .tabItem { Label("Charts", systemImage: "chart.line.uptrend.xyaxis.circle") }
            }
        }
    }
    
    init() {
        do {
            container = try ModelContainer(for: Activity.self)
        } catch let error {
            print(error)
            fatalError("Failed to create ModelContainer for Activity.")
        }
    }
}
