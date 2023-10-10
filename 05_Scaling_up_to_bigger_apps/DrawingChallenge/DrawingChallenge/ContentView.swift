//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by Adnan Boxwala on 09.10.23.
//

import SwiftUI

// MARK: - Challenge 1, 2

struct Arrow: Shape {
    var lineWidth: Double
    
    var animatableData: Double {
        get { lineWidth }
        set { lineWidth = newValue }
    }
    
    let rectWidth = 100.0
    let rectHeight = 300.0
    let triangleBase = 200.0
    let triangleHeight = 150.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // triangle
        path.move(to: CGPoint(x: rect.midX, y: rect.midY - triangleHeight))
        path.addLine(to: CGPoint(x: rect.midX - triangleBase / 2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + triangleBase / 2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY - triangleHeight))
        
        // rectangle
        path.addRect(CGRect(x: rect.midX - rectWidth / 2, y: rect.midY, width: rectWidth, height: rectHeight))
        
        return path.strokedPath(StrokeStyle(lineWidth: lineWidth, lineCap: .square, lineJoin: .bevel))
    }
}

struct ContentView: View {
    @State private var lineWidth = 10.0
    
    var body: some View {
        ZStack {
            Color.secondary
                .ignoresSafeArea()
            
            Arrow(lineWidth: lineWidth)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .onTapGesture {
            withAnimation {
                lineWidth = Double.random(in: 5...80)
            }
        }
    }
}


// MARK: - Challenge 3

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        // hue: 0 = red, 1 = red: but 0.1 != 1.1
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView_2: View {
    @State private var colorCycle = 0.0
    
    var body: some View {
        ColorCyclingRectangle(amount: colorCycle)
            .frame(width: 300, height: 300)
        
        Slider(value: $colorCycle, minimumValueLabel: Text("0"), maximumValueLabel: Text("1")) {
            Text("")
        }
        .padding()
    }
}



#Preview {
    ContentView()
}

#Preview {
    ContentView_2()
}
