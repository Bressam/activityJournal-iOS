//
//  ActivitiesChartsView.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import SwiftUI
import SwiftData

struct ActivitiesChartsView: View {
    @ObservedObject var viewModel: ActivitiesChartsViewModel

    var body: some View {
        NavigationStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.activitiesByCategory) { activityByCategory in
                        ActivityChartView(activityByCategory: activityByCategory)
                    }
                }
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .navigationTitle("Monthly progress")
        }.onAppear(perform: {
            viewModel.fetchActivities()
        })
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Activity.self,
                                           configurations: configuration)
        return ActivitiesChartsView(viewModel: .init(modelContext: container.mainContext))
            .modelContainer(container)
    } catch let error {
        fatalError("Preview: Failed to setup Activities charts container. \(error)")
    }
}
