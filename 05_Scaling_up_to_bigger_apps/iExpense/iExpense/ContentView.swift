//
//  ContentView.swift
//  iExpense
//
//  Created by Adnan Boxwala on 03.10.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ExpensesView(expenses: expenses, type: "Personal")
                } header: {
                    Text("Personal")
                }
                
                Section {
                    ExpensesView(expenses: expenses, type: "Business")
                } header: {
                    Text("Business")
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}

#Preview {
    ContentView()
}
