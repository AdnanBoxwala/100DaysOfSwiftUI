//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Adnan Boxwala on 14.10.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.details.type) {
                        ForEach(Order.Details.types.indices) {
                            Text(Order.Details.types[$0])
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    Stepper("Number of cakes: \(order.details.quantity)", value: $order.details.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.details.specialRequestEnabled.animation())
                    
                    if order.details.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.details.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.details.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }

                }
            }
            .navigationTitle("CupcakeCorner")
        }
    }
}

#Preview {
    ContentView()
}
