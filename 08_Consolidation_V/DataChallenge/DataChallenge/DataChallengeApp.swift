//
//  DataChallengeApp.swift
//  DataChallenge
//
//  Created by Adnan Boxwala on 29.10.23.
//

import SwiftUI

@main
struct DataChallengeApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
