//
//  Theme.swift
//  Nook
//

//  Created by Ethan on 29/9/2025.
//
//
//  Theme.swift
//  Nook
//
//  App theme with iOS 18 glass effects
//

import SwiftUI

struct Theme {
    // Main colors
    static let mainBlue = Color(red: 0.0, green: 0.478, blue: 1.0)
    static let lightBlue = Color(red: 0.4, green: 0.6, blue: 1.0)
    
    // Background colors
    static let background = Color(UIColor.systemGroupedBackground)
    static let cardBackground = Color(UIColor.secondarySystemGroupedBackground)
    
    // Glass effect colors
    static let glassWhite = Color.white.opacity(0.7)
    static let glassGray = Color.gray.opacity(0.1)
    static let glassDark = Color.black.opacity(0.05)
    
    // Text colors
    static let primaryText = Color.primary
    static let secondaryText = Color.secondary
    
    // Corner radius
    static let cornerRadius: CGFloat = 20
    static let smallRadius: CGFloat = 12
    
    // Shadows
    static let lightShadow = Color.black.opacity(0.05)
    static let mediumShadow = Color.black.opacity(0.1)
}

// Glass card modifier
struct GlassCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.ultraThinMaterial)
            .cornerRadius(Theme.cornerRadius)
            .shadow(color: Theme.lightShadow, radius: 10, y: 5)
    }
}

// Small glass card
struct SmallGlassCard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.regularMaterial)
            .cornerRadius(Theme.smallRadius)
    }
}

extension View {
    func glassCard() -> some View {
        modifier(GlassCard())
    }
    
    func smallGlassCard() -> some View {
        modifier(SmallGlassCard())
    }
}
