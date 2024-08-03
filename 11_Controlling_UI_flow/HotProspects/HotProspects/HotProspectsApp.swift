//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Adnan Boxwala on 27.07.24.
//

import SwiftData
import SwiftUI

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
