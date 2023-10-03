//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Adnan Boxwala on 03.10.23.
//

import Foundation


/// By making the struct identifiable we dont need to set the id parameter in ForEach
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
