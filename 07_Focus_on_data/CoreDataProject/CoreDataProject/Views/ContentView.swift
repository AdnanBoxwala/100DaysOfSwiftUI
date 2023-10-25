//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Adnan Boxwala on 25.10.23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        Button("Save") {
            if moc.hasChanges {
                try? moc.save()
            }
        }
    }
}

#Preview {
    ContentView()
}
