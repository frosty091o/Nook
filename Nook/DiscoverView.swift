//
//  Discover.swift
//  Nook
//
//  Created by Ethan on 29/9/2025.
//

import SwiftUI
import Combine

@MainActor
final class MapViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var status: String? = nil

    func fetchMock() async {
        isLoading = true
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 500_000_000)
        status = "Fetched 3 mock spots."
        isLoading = false
    }
}

struct DiscoverView: View {
    @StateObject private var vm = MapViewModel()

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "map")
                .font(.system(size: 48))
                .foregroundStyle(.tint)
            Text("Map tab placeholder")
                .font(AppFont.title())
            Text("Tap the button to simulate fetching nearby spots.")
                .font(AppFont.body())
                .foregroundStyle(.secondary)
            Button(action: { Task { await vm.fetchMock() } }) {
                if vm.isLoading {
                    ProgressView()
                } else {
                    Label("Fetch mock spots", systemImage: "arrow.clockwise")
                }
            }
            .buttonStyle(.borderedProminent)
            .ifLet(vm.status) { status in
                Text(status)
                    .font(AppFont.caption())
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .navigationTitle("Discover")
        .themedBackground()
    }
}

extension View {
    @ViewBuilder
    func ifLet<T>(_ value: T?, transform: (T) -> some View) -> some View {
        if let value { transform(value) } else { self }
    }
}

#Preview {
    NavigationStack { DiscoverView() }
}
