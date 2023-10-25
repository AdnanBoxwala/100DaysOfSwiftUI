//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Adnan Boxwala on 25.10.23.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
