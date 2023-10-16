//
//  ActivityChartView.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import SwiftUI
import Charts

struct ActivityChartView: View {
    @State var activityByCategory: ActivityByCategory
    var activity: Activity?
    @State private var showingPopover = false
    
    var body: some View {
        if activityByCategory.monthlyData.isEmpty {
            emptyDataView
                .containerRelativeFrame(.horizontal)
        } else {
            activityLogChartView
                .padding(16)
                .containerRelativeFrame(.horizontal)
        }
    }
    
    private var emptyDataView: some View {
        ZStack {
            ContentUnavailableView(label: {
                Label("No content for category: \(String(describing: activityByCategory.category))",
                      systemImage: "chart.line.uptrend.xyaxis.circle")
                .symbolEffect(.pulse.byLayer)
            }, description: {
                Text("New data will appear when logged at the activity details.")
                addLogToActivityButton(buttonTitle: "Do you want to log data?")
            })
        }.background(activityByCategory.category.chartDataColor.opacity(0.6).gradient)
    }
    
    private var activityLogChartView: some View {
        VStack(alignment: .leading) {
            chartHeaderView
            Chart {
                ForEach(activityByCategory.monthlyData) { monthActivity in
                    BarMark(x: .value("Month", monthActivity.date, unit: .month),
                            y: .value("Logs", monthActivity.activitiesCount))
                    .foregroundStyle(activityByCategory.category.chartDataColor.gradient)
                }
                
                if let monthlyGoal = activityByCategory.monthlyGoal {
                    let markerColor = activityByCategory.category.chartGoalMarkerColor
                    RuleMark(y: .value("Monthly Goal", monthlyGoal))
                        .foregroundStyle(markerColor)
                        .lineStyle(StrokeStyle(lineWidth:1, dash: [5]))
                        .annotation(alignment: .leading) {
                            Text("Goal")
                                .font(.subheadline.bold())
                                .foregroundStyle(markerColor)
                        }
                }
            }
        }
    }
    
    @ViewBuilder
    private var chartHeaderView: some View {
        HStack {
            Text( "\(activityByCategory.category.description.capitalized)")
                .font(.title)
                .foregroundStyle(activityByCategory.category.chartDataColor.gradient)
            Spacer()
            addLogToActivityButton(buttonTitle: "Log data")
        }
    }
    
    @ViewBuilder
    private func addLogToActivityButton(buttonTitle: String) -> some View {
        Button(buttonTitle) {
            guard activity != nil else {
                return
            }
            showingPopover = true
        }
        .fontWeight(.medium)
        .popover(isPresented: $showingPopover) {
            ActivityDetailView(isModallyPresented: true,
                               viewModel: .init(activity: activity!))
        }
    }
}

#Preview {
    let calendar = Calendar(identifier: .gregorian)
    var monthlyActivities: [MonthlyActivitiesData] = [
        .init(activitiesCount: 30,
              date: calendar.makeDate(year: 2023,
                                      month: 1)),
        .init(activitiesCount: 4,
              date: calendar.makeDate(year: 2023,
                                      month: 2)),
        .init(activitiesCount: 25,
              date: calendar.makeDate(year: 2023,
                                      month: 4)),
        .init(activitiesCount: 40,
              date: calendar.makeDate(year: 2023,
                                      month: 6)),
        .init(activitiesCount: 12,
              date: calendar.makeDate(year: 2023,
                                      month: 8))
    ]
    
    // Force empty data
    monthlyActivities = []

    return ActivityChartView(activityByCategory: .init(category: .none,
                                                       monthlyData: monthlyActivities,
                                                       monthlyGoal: 25),
                             activity: .init())
}
