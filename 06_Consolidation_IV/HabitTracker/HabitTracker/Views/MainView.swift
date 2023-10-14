//
//  ContentView.swift
//  HabitTracker
//
//  Created by Adnan Boxwala on 11.10.23.
//

import SwiftUI

struct MainView: View {
    @StateObject var activities = Activities()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            listLayout
                .navigationTitle("Habit Tracker")
                .background(.lightBackground)
                .preferredColorScheme(.light)
                .toolbar {
                    ToolbarItemGroup {
                        EditButton()
                        
                        Button {
                            showingAddExpense = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddActivityView(activities: activities)
                }
        }
    }
    
    var listLayout: some View {
        List {
            ForEach(activities.items, id: \.id) { activity in
                NavigationLink {
                    ActivityDetailView(activities: activities, activity: activity)
                } label: {
                    ActivityView(activity: activity)
                }
                .listRowBackground(Color.lightBackground)
            }
            .onDelete { activities.items.remove(atOffsets: $0) }
            .onMove{ activities.items.move(fromOffsets: $0, toOffset: $1) }
        }
        .listStyle(.plain)
        .padding(.bottom)
    }
}

#Preview {
    MainView()
}
