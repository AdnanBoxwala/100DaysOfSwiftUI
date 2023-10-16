//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Adnan Boxwala on 15.10.23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.details.name)
                    .textInputAutocapitalization(.words)
                TextField("Street address", text: $order.details.streetAddress)
                    .textInputAutocapitalization(.words)
                TextField("City", text: $order.details.city)
                    .textInputAutocapitalization(.words)
                TextField("Zip", text: $order.details.zip)
            }
            .autocorrectionDisabled()
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.details.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AddressView(order: Order())
    }
    
}
