//
//  ContentView.swift
//  HotProspects
//
//  Created by Adnan Boxwala on 27.07.24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Button("Show Tab 2") {
                selectedTab = "Two"
            }
            .tabItem {
                Label("One", systemImage: "star")
            }
            .tag("One")
            
            Button("Show Tab 1") {
                selectedTab = "One"
            }
            .tabItem {
                Label("Two", systemImage: "circle")
            }
            .tag("Two")
        }
    }
}

#Preview {
    ContentView()
}
