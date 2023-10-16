//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Adnan Boxwala on 15.10.23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.details.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
            .navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }

        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.details) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.Details.self, from: data)
            
            alertTitle = "Thank you!"
            alertMessage = "Your order for \(decodedOrder.quantity)x \(Order.Details.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingAlert = true
        } catch {
            alertTitle = "Order failed!"
            alertMessage = "Possible network issue. \nPlease try again."
            showingAlert = true
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
