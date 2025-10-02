//
//  NookApp.swift
//  Nook
//
//  Created by Ethan on 29/9/2025.
//
//
import SwiftUI
import CoreData

@main
struct NookApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var dataManager = DataManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(dataManager)
        }
    }
}
