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
            listOfCategories
                .padding(.horizontal, 16)
                .navigationTitle("Monthly progress")
                .modifier(JournalNavigationStyle())
        }.onAppear(perform: {
            viewModel.fetchActivities()
        })
    }
    
    private var listOfCategories: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.activitiesByCategory) { activityByCategory in
                    chartsCategorySection(activityByCategory: activityByCategory)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
    }
    
    private func chartsCategorySection(activityByCategory: ActivityByCategory) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(activityByCategory.category.description.capitalized)
                .foregroundStyle(activityByCategory.category.chartDataColor.gradient)
                .font(.title.bold())
            activitiesChartsList(activityByCategory: activityByCategory)
        }
        .padding([.bottom], 12)
        .containerRelativeFrame(.vertical) { lenght, axis in
            return lenght / 2.3
        }
    }
    
    private func activitiesChartsList(activityByCategory: ActivityByCategory) -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(activityByCategory.activitiesChartsData) { activitiesChartsData in
                    ActivityChartView(activity: viewModel.getActivity(by: activitiesChartsData.id),
                                      activityChartData: activitiesChartsData)
                    .cornerRadius(15)
                }
            }.scrollTargetLayout()
        }.scrollTargetBehavior(.viewAligned)
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
