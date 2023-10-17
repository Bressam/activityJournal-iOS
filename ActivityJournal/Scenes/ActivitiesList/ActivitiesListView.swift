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
    @State private var showingAlert = false
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                activitiesList
            }
            .toolbar(content: {
                animatedAddButton
            })
            .navigationTitle("Activities")
            .modifier(JournalNavigationStyle())
        }.onAppear(perform: {
            viewModel.fetchActivities()
        })
    }
    
    @ViewBuilder
    private var activitiesList: some View {
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
            .scrollContentBackground(.hidden)
            .navigationDestination(for: Activity.self) { activity in
                ActivityDetailView(viewModel: .init(activity: activity))
            }
        }
    }

    private var emptyItemsView: some View {
        ContentUnavailableView(label: {
            Label("Empty Activities", systemImage: "mail.stack")
        }, description: {
            Text("Please create a new activity with button above or batch generate mock data.")
        }, actions: {
            Button(action: {
                showingAlert = true
            }) {
                Text("Generate past data")
            }.alert("Generate past data", isPresented: $showingAlert, actions: {
                Button("Generate", role: .none) { viewModel.generateMockData() }
                Button("Cancel", role: .cancel) { }
            }, message: {
                Text("This will generate some history mock data. Useful to test charts without having to manually generate all data.")
            })
        })
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
        let activitiesService = ActivitiesServiceFactory.shared.createActivitiesService(mocked: true)
        activitiesService.generateMockData()
        return ActivitiesListView(viewModel: .init(activitiesService: activitiesService))
    } catch let error {
        fatalError("Preview: Failed to setup Activity container. \(error)")
    }
}
