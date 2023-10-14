//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by Adnan Boxwala on 12.10.23.
//

import SwiftUI

struct ActivityDetailView: View {
    @ObservedObject var activities: Activities
    let activity: Activity
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.lightBackground
                    .ignoresSafeArea()
                
                VStack {
                    prettyDivider
                        .foregroundStyle(Color.darkBackground)
                    
                    Text(activity.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack {
                        incrementButton
                        Text("Tap for another successful completion.")
                            .foregroundStyle(Color.darkBackground)
                            .font(.caption)
                    }
                                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationTitle(activity.title)
        }
    }
    
    var incrementButton: some View {
        Button {
            increaseCount()
        } label: {
            ZStack {
                Circle()
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(maxWidth: 150)
                    .overlay {
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 2))
                            .foregroundStyle(Color.darkBackground)
                    }
                
                Text("\(activity.count)")
                    .font(.largeTitle)
                    .foregroundStyle(Color.darkBackground)
            }
        }
    }
    
    func increaseCount() {
        var copyActivity = activity
        copyActivity.count += 1
        
        if let idx = activities.items.firstIndex(of: activity) {
            activities.items[idx] = copyActivity
        }
    }
    
    var prettyDivider: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.secondary)
            .padding(.vertical)
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static let activity = Activity(title: "Test", description: "Sample description", count: 2)
    static var previews: some View {
        ActivityDetailView(activities: Activities(), activity: activity)
    }
}
