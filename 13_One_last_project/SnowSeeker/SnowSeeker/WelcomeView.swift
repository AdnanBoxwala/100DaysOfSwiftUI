//
//  WelcomeVIew.swift
//  SnowSeeker
//
//  Created by Adnan Boxwala on 28.08.24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            
            Text("Please select a resort from the left-hand view; swipe from the edge to show it.")
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    WelcomeView()
}
