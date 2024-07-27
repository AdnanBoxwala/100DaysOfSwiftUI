//
//  ContentView.swift
//  HotProspects
//
//  Created by Adnan Boxwala on 27.07.24.
//

import SwiftUI

struct ContentView: View {
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
//    Use optional string for single selection
//    @State private var selection: String?
    @State private var selection = Set<String>()
    
    var body: some View {
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        
//        if let selection {
        if selection.isEmpty == false {
//            Text("You selected \(selection)")
            Text("You selected \(selection.formatted())")
        }
        
        // Multiselection can be enabled with gesture
        // Right swip with two fingers
        // Not obvious, so use EditButton
        EditButton()
    }
}

#Preview {
    ContentView()
}
