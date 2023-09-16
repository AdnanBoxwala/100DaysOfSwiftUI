//
//  ViewModifiers.swift
//  GuessTheFlag
//
//  Created by Adnan Boxwala on 16.09.23.
//

import SwiftUI

/// Modifier to make views have a prominent title
struct ProminentTitle: ViewModifier {
    var color: Color
    var font: Font
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(color)
    }
}

extension View {
    /// Modifier to make views have a prominent title
    /// - Parameters:
    ///   - color: foreground color for the text
    ///   - font: font size for the text
    /// - Returns: modified view with desired color and font
    func prominentTitle(_ color: Color, _ font: Font) -> some View {
        modifier(ProminentTitle(color: color, font: font))
    }
}
