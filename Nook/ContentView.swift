//
//  ContentView.swift
//  Nook
//
//  Created by Ethan on 2/10/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    init() {
        // Customize tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.3)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            MapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("Map")
                }
                .tag(0)
            
            ListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Browse")
                }
                .tag(1)
            
            SavedView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Saved")
                }
                .tag(2)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(3)
        }
        .accentColor(Theme.mainBlue)
    }
}

#Preview {
    ContentView()
}
