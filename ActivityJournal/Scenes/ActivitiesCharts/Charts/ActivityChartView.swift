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
    
    var emptyDataView: some View {
        ZStack {
            ContentUnavailableView(label: {
                Label("No content for category: \(String(describing: activityByCategory.category))",
                      systemImage: "chart.line.uptrend.xyaxis.circle")
                .symbolEffect(.pulse.byLayer)
            }, description: {
                Text("New data will appear when logged at the activity details.")
            })
        }.background(activityByCategory.category.chartDataColor.opacity(0.8).gradient)
    }
    
    var activityLogChartView: some View {
        VStack(alignment: .leading) {
            Text( "\(activityByCategory.category.description.capitalized)")
                .font(.title)
                .foregroundStyle(activityByCategory.category.chartDataColor.gradient)
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
}

#Preview {
    let calendar = Calendar(identifier: .gregorian)
    var monthlyActivities: [MonthActivities] = [
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

    return ActivityChartView(activityByCategory: .init(category: .sport,
                                                       monthlyData: monthlyActivities,
                                                       monthlyGoal: 25))
}