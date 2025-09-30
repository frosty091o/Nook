//
//  Discover.swift
//  Nook
//
//  Created by Ethan on 29/9/2025.
//

import SwiftUI
import Combine

@MainActor
final class DiscoverViewModel: ObservableObject {
    @Published var isLoading = false
}

struct DiscoverView: View {
    @StateObject private var vm = DiscoverViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "map")
                .font(.system(size: 48))
                .foregroundStyle(.tint)
            Text("Discover")
                .font(AppFont.title())
            Text("Test")
                .font(AppFont.body())
                .foregroundStyle(.secondary)
        }
        .padding()
        .navigationTitle("Discover")
        .themedBackground()
    }
}

#Preview {
    NavigationStack { DiscoverView() }
}
