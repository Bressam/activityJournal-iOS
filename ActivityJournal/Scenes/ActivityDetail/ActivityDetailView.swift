//
//  ContentView.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 15/10/23.
//

import SwiftUI
import SwiftData

struct ActivityDetailView: View {
    @Bindable var viewModel: ActivityDetailViewModel
    
    var body: some View {
        Form {
            detailsSection
            activityLogSection
        }
        .navigationTitle("Edit activity")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var detailsSection: some View {
        Section("Activity details") {
            TextField("Title", text: $viewModel.activity.title)
            TextField("Description", text: $viewModel.activity.activityDescription)
                .lineLimit(2, reservesSpace: true)
            Picker("Category", selection: $viewModel.activity.category) {
                ForEach(ActivityCategory.allCases, id: \.self) { category in
                    Text(category.name).tag(category)
                }
            }
        }
    }
    
    private var activityLogSection: some View {
        Section {
            List {
                ForEach($viewModel.activity.sortedLoggedData) { loggedData in
                    HStack {
                        DatePicker("Date", selection: loggedData.date)
                    }
                }.onDelete(perform: { indexSet in
                    viewModel.deleteActivity(at: indexSet)
                })
            }
        } header: {
            activityLogsHeader
        }
    }
    
    private var activityLogsHeader: some View {
        HStack {
            Text("Activity Log")
            Spacer()
            Button {
                viewModel.logActivity()
            } label: {
                Text("Log")
                Image(systemName: "plus")
            }
            .symbolEffect(.bounce.up,
                          value: viewModel.activity.loggedData)
        }
    }
}

#Preview {
    let dummyActivity: Activity = .init(title: "Test", loggedData: [])
    let dummyViewModel: ActivityDetailViewModel = .init(activity: dummyActivity)
    return ActivityDetailView(viewModel: dummyViewModel)
}
