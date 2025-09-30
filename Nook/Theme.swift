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

struct ThemedBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(AppColor.background)
    }
}

extension View {
    func themedBackground() -> some View { modifier(ThemedBackground()) }
}
