//
//  DataManager.swift
//  Flashzilla
//
//  Created by Adnan Boxwala on 13.08.24.
//

import Foundation
import OSLog

struct DataManager {
    static let fileUrl = URL.documentsDirectory.appending(path: "flash_cards.json")
    
    static func saveData(_ cards: [Card]) {
        guard let data = try? JSONEncoder().encode(cards) else {
            Logger().error("Failed to encode flash cards.")
            return
        }
        
        do {
            try data.write(to: fileUrl, options: [.atomic, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func loadData() -> [Card] {
        guard let data = try? Data(contentsOf: fileUrl) else {
            Logger().error("Failed to read data from documents directory.")
            return []
        }
        
        if let cards = try? JSONDecoder().decode([Card].self, from: data) {
            return cards
        }
        
        return []
    }
}
