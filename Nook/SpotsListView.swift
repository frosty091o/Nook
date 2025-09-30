//
//  SpotsListView.swift
//  Nook
//
//  Created by Ethan on 29/9/2025.
//

import SwiftUI
import Combine

@MainActor
final class SpotsListViewModel: ObservableObject {
    @Published var isLoading = false
}

struct SpotsListView: View {
    @StateObject private var vm = SpotsListViewModel()

    var body: some View {
        List {
            Text("tsesting")
        }
        .navigationTitle("List")
    }
}

#Preview {
    NavigationStack { SpotsListView() }
}

