//
//  Activities.swift
//  HabitTracker
//
//  Created by Adnan Boxwala on 12.10.23.
//

import Foundation

class Activities: ObservableObject {
    @Published var items: [Activity] {
        didSet {
            if let encodedItems = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encodedItems, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
