//
//  ActivityChartView.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 16/10/23.
//

import SwiftUI
import Charts
import SwiftData

struct ActivityChartView: View {
    var activity: Activity?
    @State var activityChartData: ActivityChartData
    @State private var showingPopover = false
    var didDismissActivityDefail: (() -> Void)? = nil
    
    var body: some View {
        if activityChartData.monthlyData.isEmpty {
            emptyDataView
                .padding(16)
                .containerRelativeFrame(.horizontal)
        } else {
            activityLogChartView
                .padding(16)
                .containerRelativeFrame(.horizontal)
        }
    }
    
    @ViewBuilder
    private var emptyDataView: some View {
        let activityTitle = activityChartData.title.isEmpty ? "Unamed Activity" : activityChartData.title
        ZStack {
            ContentUnavailableView(label: {
                Label("No logged data for activity: \(activityTitle)",
                      systemImage: "chart.line.uptrend.xyaxis.circle")
                .symbolEffect(.pulse.byLayer)
            }, description: {
                Text("New data will appear when logged at the activity details.")
                addLogToActivityButton(buttonTitle: "Do you want to log data?")
            })
        }
        .background(activityChartData.category.chartDataColor.opacity(0.6).gradient)
        .clipShape(.rect(cornerRadius: 16))
    }
    
    private var activityLogChartView: some View {
        VStack(alignment: .leading) {
            chartHeaderView
            Chart {
                ForEach(activityChartData.monthlyData) { monthActivity in
                    BarMark(x: .value("Month", monthActivity.date, unit: .month),
                            y: .value("Logs", monthActivity.activitiesCount),
                            width: .init(integerLiteral: 32))
                    .foregroundStyle(activityChartData.category.chartDataColor.gradient)
                }
                
                if let monthlyGoal = activityChartData.monthlyGoal {
                    let markerColor = activityChartData.category.chartGoalMarkerColor
                    RuleMark(y: .value("Monthly Goal", monthlyGoal))
                        .foregroundStyle(markerColor)
                        .lineStyle(StrokeStyle(lineWidth:1, dash: [5]))
                        .annotation(alignment: .leading) {
                            Text("Goal")
                                .font(.subheadline.bold())
                                .foregroundStyle(markerColor)
                        }
                }
            }.chartXAxis {
                AxisMarks(values: .stride(by: .month, count: 1))
            }.chartYAxis {
                let highestMonthData = activityChartData.monthlyData.sorted(by: { $0.activitiesCount > $1.activitiesCount }).first!
                AxisMarks(values: [0, (Double(highestMonthData.activitiesCount) * 1.1)])
            }
        }
    }
    
    @ViewBuilder
    private var chartHeaderView: some View {
        let chartTitle = activity?.title.isEmpty == true ? "Unamed activity" : activity?.title
        HStack {
            Text(chartTitle ?? "Unamed activity")
                .font(.title2)
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
        .sheet(isPresented: $showingPopover,
               onDismiss: didDismissActivityDefail) {
            ActivityDetailView(isModallyPresented: true,
                               viewModel: .init(activity: activity!))
        }
    }
}

#Preview {
    let calendar = Calendar(identifier: .gregorian)
    let monthlyActivities: [MonthlyActivitiesData] = [
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
    // let emptymonthlyActivities: [MonthlyActivitiesData] = []
    
    let activity: Activity = .init()
    return ActivityChartView(activity: activity,
                             activityChartData: .init(id: activity.id,
                                                      title: "Chart Title",
                                                      category: .none,
                                                      monthlyData: monthlyActivities,
                                                      monthlyGoal: 25))
}
