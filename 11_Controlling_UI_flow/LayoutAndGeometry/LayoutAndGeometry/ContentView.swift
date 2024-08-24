//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Adnan Boxwala on 24.08.24.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                        // Challenge 3:
//                            .background(colors[index % 7])
                            .background(Color(hue: min(1.0, proxy.frame(in: .global).minY / fullView.size.height),
                                              saturation: 1.0,
                                              brightness: 1.0))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height * 0.5) / 5,
                                              axis: (x: 0, y: 1, z: 0))
                        // Challenge 1:
                            .opacity(proxy.frame(in: .global).minY / 200)
                        // Challenge 2:
                            .scaleEffect(max(0.5, proxy.frame(in: .global).minY / (fullView.size.height * 0.5)))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
