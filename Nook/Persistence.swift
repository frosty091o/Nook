//
//  Persistence.swift
//  Nook
//
//  Created by Ethan on 2/10/2025.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    // Preview for SwiftUI previews
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // Add sample data for previews
        for i in 0..<3 {
            let newSpot = SavedSpot(context: viewContext)
            newSpot.id = UUID()
            newSpot.name = "Sample Spot \(i)"
            newSpot.address = "123 Sample St"
            newSpot.type = "cafe"
            newSpot.rating = 4.5
            newSpot.hasWifi = true
            newSpot.hasPower = true
            newSpot.latitude = -33.8688
            newSpot.longitude = 151.2093
            newSpot.savedDate = Date()
        }
        
        do {
            try viewContext.save()
        } catch {
            print("Error creating preview data: \(error)")
        }
        
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Nook")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Core Data error: \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    // Save context
    func save() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
    }
    
    // Delete all data (for settings)
    func deleteAllData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = SavedSpot.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(deleteRequest)
            save()
        } catch {
            print("Error deleting data: \(error)")
        }
    }
}
