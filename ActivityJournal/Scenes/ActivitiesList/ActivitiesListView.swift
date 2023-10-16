//
//  ActivitiesListView.swift
//  ActivityJournal
//
//  Created by Giovanne Bressam on 15/10/23.
//

import SwiftUI
import SwiftData

struct ActivityItem: View {
    @State var activity: Activity
    
    var body: some View {
        let latestLog = activity.loggedData.sorted(by: {$0.date > $1.date }).first
        let latestLogText: String = latestLog?.date.formatted(date: .long, time: .omitted) ?? "Not available"

        HStack(alignment: .center) {
            Text(activity.category.emoji)
            VStack(alignment: .leading) {
                Text(activity.title.isEmpty ? "New Activity!" : activity.title)
                Text("Last report: \(latestLogText)")
            }
        }
    }
}

struct ActivitiesListView: View {
    @ObservedObject var viewModel: ActivitiesListViewModel
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                    .ignoresSafeArea()
                activitiesList
            }
            .toolbar(content: {
                animatedAddButton
            })
            .navigationTitle("Activities")
            .navigationBarTitleDisplayMode(.large)
        }.onAppear(perform: {
            viewModel.fetchActivities()
        })
    }
    
    @ViewBuilder
    var activitiesList: some View {
        if viewModel.activities.isEmpty {
            emptyItemsView
        } else {
            List {
                ForEach(viewModel.activities) { activity in
                    NavigationLink(value: activity) {
                        ActivityItem(activity: activity)
                    }
                }.onDelete(perform: { indexSet in
                    viewModel.deleteActivity(at: indexSet)
                })
            }
            .navigationDestination(for: Activity.self) { activity in
                ActivityDetailView(viewModel: .init(activity: activity))
            }
        }
    }
    
    var emptyItemsView: some View {
        ContentUnavailableView("Empty Activities",
                               systemImage: "mail.stack",
                               description: Text("Please create a new activity with button above."))
    }
    
    private var animatedAddButton: some View {
        Button {
            let activity = viewModel.createActivity()
            path.append(activity)
        } label: {
            Text("Add")
            Image(systemName: "mail.stack")
        }
        .symbolEffect(.bounce.up, value: viewModel.activities)
        .font(.system(size: 22))
        .foregroundStyle(Color.green)
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Activity.self,
                                           configurations: configuration)
        return ActivitiesListView(viewModel: .init(modelContext: container.mainContext))
            .modelContainer(container)
    } catch let error {
        fatalError("Preview: Failed to setup Activity container. \(error)")
    }
}
