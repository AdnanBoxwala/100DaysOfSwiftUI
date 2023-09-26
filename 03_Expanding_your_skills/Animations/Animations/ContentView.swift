//
//  ContentView.swift
//  Animations
//
//  Created by Adnan Boxwala on 23.09.23.
//

import SwiftUI


// MARK: - Custom transitions

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
        
    }
}

struct ContentView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
    }
}



#Preview {
    ContentView()
}


// MARK: - Implicit animation
// This uses an animation modifier
//
//struct ContentView: View {
//    @State private var animationAmount = 1.0
//    var body: some View {
//        Button("tap me") {
//            animationAmount += 1
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .scaleEffect(animationAmount)
//        .animation(.default, value: animationAmount)
//
//    }
//}


// MARK: - Customising animations
// Can add modifiers on animation type and also change duration
//
//struct ContentView: View {
//    @State private var animationAmount = 1.0
//    var body: some View {
//        Button("tap me") {
//            // animationAmount += 1
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .overlay(
//            Circle()
//                .stroke(.red)
//                .scaleEffect(animationAmount)
//                .opacity(2 - animationAmount)
//                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false),
//                           value: animationAmount)
//        )
//        .onAppear {
//            animationAmount = 2
//        }
//        
//    }
//}


// MARK: - Animation with Binding
// Here animation is attached to a binding value. It does not know the view will be animated
//
//struct ContentView: View {
//    @State private var animationAmount = 1.0
//    
//    var body: some View {
//        print(animationAmount)
//        
//        return VStack {
//            Stepper("Scale amount", value: $animationAmount.animation(
//                .easeInOut(duration: 1)
//                .repeatCount(3, autoreverses: true)), in: 1...10)
//            
//            Spacer()
//            
//            Button("tap me") {
//                animationAmount += 1
//            }
//            .padding(50)
//            .background(.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//        }
//    }
//}


// MARK: - Explicit animation using with animation function
//struct ContentView: View {
//    @State private var animationAmount = 0.0
//
//    var body: some View {
//        Button("Tap me") {
//            withAnimation {
//                animationAmount += 360
//            }
//
//        }
//        .padding(50)
//        .background(.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .rotation3DEffect( .degrees(animationAmount), axis: (x: 0, y: 0, z: 1))
//    }
//}


// MARK: - Multiple animations
// Multiple animation modifiers can be added to a view.
// Each animation modifier controls the part of the view before it upto the preview animation
//
//struct ContentView: View {
//    @State private var enabled = false
//
//    var body: some View {
//        Button("Tap me") {
//            enabled.toggle()
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? .blue : .red)
//        .animation(.default, value: enabled)
//        .foregroundColor(.white)
//        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//        .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
//    }
//}


// MARK: - Drag gesture
//
//struct ContentView: View {
//    @State private var dragAmount = CGSize.zero
//
//    var body: some View {
//        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .offset(dragAmount)
//            .gesture(
//                DragGesture()
//                    .onChanged { dragAmount = $0.translation }
//                    .onEnded { _ in
//                        withAnimation {
//                            dragAmount = .zero
//                        }
//                    }
//            )
//           // .animation(.spring(), value: dragAmount)
//    }
//}


// MARK: - Animating gestures
// default animation in iOS 17 is spring
//struct ContentView: View {
//    let letters = Array("Hello, SwiftUI")
//    @State private var enabled = false
//    @State private var dragAmount = CGSize.zero
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(0..<letters.count, id: \.self) { num in
//                Text(String(letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(enabled ? .blue : .red)
//                    .offset(dragAmount)
//                    .animation(
//                        .linear.delay(Double(num) / 20),
//                        value: dragAmount
//                    )
//            }
//        }
//        .gesture(
//            DragGesture()
//                .onChanged { dragAmount = $0.translation }
//                .onEnded { _ in
//                    dragAmount = .zero
//                    enabled.toggle()
//                }
//        )
//    }
//}


// MARK: - Showing and hiding views with transition
//
//struct ContentView: View {
//    @State private var showingRed = false
//    var body: some View {
//        VStack {
//            Button("Tap me") {
//                withAnimation {
//                    showingRed.toggle()
//                }
//            }
//            if showingRed {
//                Rectangle()
//                    .fill(.red)
//                    .frame(width: 200, height: 200)
//                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
//            }
//        }
//    }
//}
