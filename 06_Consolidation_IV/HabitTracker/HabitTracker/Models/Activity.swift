//
//  Activity.swift
//  HabitTracker
//
//  Created by Adnan Boxwala on 12.10.23.
//

import Foundation

struct Activity: Codable, Identifiable, Equatable {
    var id = UUID()
    
    let title: String
    let description: String
    var count: Int
}
