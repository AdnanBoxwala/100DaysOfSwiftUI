//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by Adnan Boxwala on 16.08.24.
//

import SwiftData
import SwiftUI

@main
struct DiceRollApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: RolledValue.self)
    }
}
