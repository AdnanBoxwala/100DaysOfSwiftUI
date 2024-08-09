//
//  CardView.swift
//  Flashzilla
//
//  Created by Adnan Boxwala on 09.08.24.
//

import SwiftUI

struct CardView: View {
    @State private var isShowingAnswer = false
    let card: Card
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .fill(.white)
                .shadow(radius: 10)
            
            VStack {
                Text(card.prompt)
                    .font(.largeTitle)
                    .foregroundStyle(.black)
                
                if isShowingAnswer {
                    Text(card.answer)
                        .font(.title)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250) // smallest iPhones have landscape width of 480 points
        .onTapGesture {
            isShowingAnswer.toggle()
        }
    }
}

#Preview {
    CardView(card: .example)
}
