//
//  Theme.swift
//  Nook
//

//  Created by Ethan on 29/9/2025.
//
import SwiftUI

enum AppColor {
    static let accent = Color.accentColor
    static let background = Color(UIColor.systemBackground)
    static let secondaryBackground = Color(UIColor.secondarySystemBackground)
    static let label = Color.primary
    static let secondaryLabel = Color.secondary
}

enum AppFont {
    static func title(_ weight: Font.Weight = .semibold) -> Font { .system(.title2, design: .rounded).weight(weight) }
    static func body(_ weight: Font.Weight = .regular) -> Font { .system(.body, design: .rounded).weight(weight) }
    static func caption(_ weight: Font.Weight = .regular) -> Font { .system(.caption, design: .rounded).weight(weight) }
}

enum AppSpacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
}

struct ThemedBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppColor.background)
    }
}

extension View {
    func themedBackground() -> some View { modifier(ThemedBackground()) }
}

