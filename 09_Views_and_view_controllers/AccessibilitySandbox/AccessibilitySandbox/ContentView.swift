//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Adnan Boxwala on 28.01.24.
//

import SwiftUI

struct ContentView: View {
    @State private var value = 10
    
    var body: some View {
        VStack {
            Text("value: \(value)")
            
            Button("increment") {
                value += 1
            }
            
            Button("decrement") {
                value -= 1
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("not handled")
            }
        }
    }
}

#Preview {
    ContentView()
}
