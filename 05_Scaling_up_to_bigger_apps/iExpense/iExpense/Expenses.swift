//
//  Expenses.swift
//  iExpense
//
//  Created by Adnan Boxwala on 03.10.23.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    var personalExpenses: [ExpenseItem] {
        items.filter({$0.type == "Personal"})
    }
    
    var businessExpenses: [ExpenseItem] {
        items.filter({$0.type == "Business"})
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
