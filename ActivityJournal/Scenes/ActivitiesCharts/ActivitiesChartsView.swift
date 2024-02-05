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
    
    init(viewModel: ActivitiesChartsViewModel) {
        self.viewModel = viewModel

        viewModel.onViewAppear()
    }
    
    var body: some View {
        NavigationStack {
            contentView
                .navigationTitle("Monthly progress")
                .modifier(JournalNavigationStyle())
        }.onAppear(perform: {
            viewModel.fetchActivities()
        })
    }
    
    @ViewBuilder
    private var contentView: some View {
        if viewModel.activitiesByCategory.isEmpty {
            emptyItemsView
        } else {
            listOfCategories
                .padding(.horizontal, 16)
        }
    }
    
    private var emptyItemsView: some View {
        ContentUnavailableView(label: {
            Label("No activity found.",
                  systemImage: "chart.line.uptrend.xyaxis.circle")
            .symbolEffect(.pulse.byLayer)
        }, description: {
            Text("You can check your progress and charts when an activity is created")
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
                                      activityChartData: activitiesChartsData,
                                      didDismissActivityDefail: {
                        viewModel.fetchActivities()
                    }, logActivityHandler: getActivityDetailView)
                    .cornerRadius(15)
                }
            }.scrollTargetLayout()
        }.scrollTargetBehavior(.viewAligned)
    }
    
    func getActivityDetailView(activity: Activity) -> ActivityDetailView {
        let activityDetailViewModel = viewModel.getActivityDetailViewModel(activity: activity)
        return ActivityDetailView(isModallyPresented: true,
                                  viewModel: activityDetailViewModel)
    }
}

#Preview {
    let activitiesService = ActivitiesServiceFactory.shared.createActivitiesService(mocked: true)
    //        activitiesService.generateMockData()
    let dummyAnalyticsService = AnalyticsServiceFactory.shared.createAnalyticsServiceFactory(config: .mocked)
    return ActivitiesChartsView(viewModel: .init(activitiesService: activitiesService, analyticsService: dummyAnalyticsService))
}
