//
//  RootTabView.swift
//  Nook
//
//  Created by Ethan on 1/10/2025.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            NavigationStack { DiscoverView() }
                .tabItem { Label("Discover", systemImage: "map") }

            NavigationStack { SpotsListView() }
                .tabItem { Label("List", systemImage: "list.bullet") }
        }
    }
}

#Preview {
    RootTabView()
}
