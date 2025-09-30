//
//  NookApp.swift
//  Nook
//
//  Created by Ethan on 29/9/2025.
//

import SwiftUI
import CoreData

@main
struct NookApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    DiscoverView()
                }
                .tabItem {
                    Label("Discover", systemImage: "map")
                }

                NavigationStack {
                    SpotsListView()
                }
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
