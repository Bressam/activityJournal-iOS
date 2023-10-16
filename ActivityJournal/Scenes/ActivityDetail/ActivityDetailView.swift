//
//  ContentView.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 15/10/23.
//

import SwiftUI
import SwiftData

struct ActivityDetailView: View {
    private let viewtitle: String = "Edit activity"
    let isModallyPresented: Bool
    @Bindable var viewModel: ActivityDetailViewModel
    
    init(isModallyPresented: Bool = false,
         viewModel: ActivityDetailViewModel) {
        self.isModallyPresented = isModallyPresented
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground).ignoresSafeArea()
            VStack {
                headerView
                Form {
                    detailsSection
                    activityLogSection
                }
            }
        }
        .navigationTitle(viewtitle)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private var headerView: some View {
        if isModallyPresented {
            Text(viewtitle)
                .font(.headline)
                .foregroundStyle(.primary)
                .padding([.top], 16)
        } else {
            EmptyView()
        }
    }
    
    private var detailsSection: some View {
        Section("Activity details") {
            TextField("Title", text: $viewModel.activity.title)
            TextField("Description", text: $viewModel.activity.activityDescription)
                .lineLimit(2, reservesSpace: true)
            TextField("Monthly Goal", value: $viewModel.activity.monthlyGoal,
                      format: .number)
                .keyboardType(.numbersAndPunctuation)
            Picker("Category", selection: $viewModel.activity.category) {
                ForEach(ActivityCategory.allCases, id: \.self) { category in
                    Text(category.name).tag(category)
                }
            }
        }.multilineTextAlignment(TextAlignment.leading)
    }
    
    private var activityLogSection: some View {
        Section {
            List {
                ForEach($viewModel.activity.sortedLoggedData) { loggedData in
                    HStack {
                        DatePicker("Done at", selection: loggedData.date)
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
    return ActivityDetailView(isModallyPresented: true,
                              viewModel: dummyViewModel)
}
