//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Adnan Boxwala on 28.07.24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
