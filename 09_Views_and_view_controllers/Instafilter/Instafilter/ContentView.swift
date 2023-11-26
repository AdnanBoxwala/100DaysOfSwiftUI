//
//  ContentView.swift
//  Instafilter
//
//  Created by Adnan Boxwala on 26.11.23.
//

import SwiftUI

struct ContentView: View {
    /// using didSet on the state property, only triggers the closure when the state struct is changed using the non-mutating setter.
    /// When we change the property using binding, the underlying wrappedValue is changed directly and the setter is not triggered.
    @State private var blurAmount = 0.0 {
        didSet {
            print("New value is \(blurAmount)")
        }
    }
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .blur(radius: blurAmount)
            
            Slider(value: $blurAmount, in: 0...20)
            
            Button("Random Blur") {
                blurAmount = Double.random(in: 0...20)
            }
        }
    }
}

#Preview {
    ContentView()
}
