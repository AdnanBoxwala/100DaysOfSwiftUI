//
//  DiceView.swift
//  DiceRoll
//
//  Created by Adnan Boxwala on 16.08.24.
//

import SwiftUI

struct DiceView: View {
    var rolledNumber: Int
    
    var body: some View {
        GeometryReader { proxy in
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .strokeBorder(.black, lineWidth: 3)
                .aspectRatio(1.0, contentMode: .fit)
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
            
            Text("\(rolledNumber)")
                .font(.system(size: proxy.size.height > proxy.size.width ? proxy.size.width * 0.4: proxy.size.height * 0.4))
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
        }
    }
}

#Preview {
    DiceView(rolledNumber: 5)
}
