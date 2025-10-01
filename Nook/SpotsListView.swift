//
//  SpotsListView.swift
//  Nook
//
//  Created by Ethan on 29/9/2025.
//

import SwiftUI
import Combine

@MainActor
final class ListViewModel: ObservableObject {
    @Published var items: [String] = [
        "Campus Library",
        "Quiet Corner Cafe",
        "Riverside Park Benches"
    ]
}

struct SpotsListView: View {
    @StateObject private var vm = ListViewModel()

    var body: some View {
        List(vm.items, id: \.self) { item in
            Label(item, systemImage: "mappin.and.ellipse")
        }
        .navigationTitle("List")
    }
}

#Preview {
    NavigationStack { SpotsListView() }
}
