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
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
