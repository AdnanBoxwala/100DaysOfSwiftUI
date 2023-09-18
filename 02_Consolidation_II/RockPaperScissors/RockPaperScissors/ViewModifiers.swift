//
//  ViewModifiers.swift
//  RockPaperScissors
//
//  Created by Adnan Boxwala on 17.09.23.
//

import SwiftUI

struct PadWithSpacer: ViewModifier {
    func body(content: Content) -> some View {
        Spacer()
        content
        Spacer()
    }
}

extension View {
    func padWithSpacer() -> some View {
        modifier(PadWithSpacer())
    }
}
