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
            Section {
                List {
                    ForEach($viewModel.activity.loggedData) { loggedData in
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
        .navigationTitle("Edit activity")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    var activityLogsHeader: some View {
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
    do {
        var dummyActivity: Activity = .init(title: "Test", loggedData: [])
        let dummyViewModel: ActivityDetailViewModel = .init(activity: dummyActivity)
        return ActivityDetailView(viewModel: dummyViewModel)
    } catch let error {
        fatalError("Failed to create ModelContainer for Activity. Error: \(error)")
    }
}
