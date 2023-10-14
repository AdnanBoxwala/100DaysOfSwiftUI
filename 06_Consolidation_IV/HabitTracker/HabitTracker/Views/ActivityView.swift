//
//  ActivityView.swift
//  HabitTracker
//
//  Created by Adnan Boxwala on 14.10.23.
//

import SwiftUI

struct ActivityView: View {
    let activity: Activity
    
    var body: some View {
        HStack {
            Text(activity.title)
                .font(.title2)
            
            Spacer()

            Text("\(activity.count)")
                .bold()
                .padding()
                .background(.darkBackground)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
        }
        .padding()
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .overlay {
            RoundedRectangle(cornerRadius: 25.0)
                .stroke(.darkBackground)
        }
    }
}

#Preview {
    ActivityView(activity: Activity(title: "test", description: "description", count: 100))
}
