//
//  ExpensesView.swift
//  iExpense
//
//  Created by Adnan Boxwala on 03.10.23.
//

import SwiftUI

struct ExpensesView: View {
    @ObservedObject var expenses: Expenses
    let type: String
    
    var body: some View {
        ForEach(expenses.items.filter({$0.type == type})) { item in
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                }
                
                Spacer()
                
                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                    .foregroundStyle(item.amount > 100 ? .red : (item.amount > 10 ? .orange : .blue))
                    .fontWeight(item.amount > 100 ? .heavy : (item.amount > 10 ? .medium : .light))
            }
        }
        .onDelete(perform: type == "Personal" ? removePersonalItem : removeBusinessItem)
    }
    
    func removePersonalItem(at offsets: IndexSet) {
        let id = expenses.personalExpenses[offsets.first!].id
        guard let idx = expenses.items.firstIndex(where: { $0.id == id }) else {
            return
        }
        expenses.items.remove(at: idx)
    }
    
    func removeBusinessItem(at offsets: IndexSet) {
        let id = expenses.businessExpenses[offsets.first!].id
        guard let idx = expenses.items.firstIndex(where: { $0.id == id }) else {
            return
        }
        expenses.items.remove(at: idx)
    }
}

#Preview {
    ExpensesView(expenses: Expenses(), type: "Personal")
}
