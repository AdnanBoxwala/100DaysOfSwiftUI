//
//  ContentView.swift
//  AccessibilitySandbox
//
//  Created by Adnan Boxwala on 28.01.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // decorative says image is not important and isnt read out by voiceover
//        Image(decorative: "ales-krivec-15949")
//            .accessibilityHidden(true) // hides the view from voiceover completely
        
        VStack {
            Text("Your score is")
            Text("1000")
                .font(.title)
        }
//        .accessibilityElement(children: .combine) // adds a short pause between elements
        .accessibilityElement(children: .ignore) // since both text view are related to each other and should be read as single entity.
        .accessibilityLabel("Your score is 1000") // now read without the pause
    }
}

#Preview {
    ContentView()
}
