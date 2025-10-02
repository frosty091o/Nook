//
//  DataManager.swift
//  Nook
//
//  Created by Ethan on 2/10/2025.
//

import Foundation
import CoreData
import Combine

class DataManager: ObservableObject {
    let container: NSPersistentContainer
    @Published var savedSpots: [SavedSpot] = []
    
    init(container: NSPersistentContainer = PersistenceController.shared.container) {
        self.container = container
        fetchSavedSpots()
    }
    
    // Fetch all saved spots
    func fetchSavedSpots() {
        let request: NSFetchRequest<SavedSpot> = SavedSpot.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \SavedSpot.savedDate, ascending: false)]
        
        do {
            savedSpots = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching saved spots: \(error)")
        }
    }
    
    // Save a spot
    func saveSpot(_ spot: StudySpot) {
        // Check if already saved
        if isSpotSaved(spot) {
            return
        }
        
        let savedSpot = SavedSpot(context: container.viewContext)
        savedSpot.id = spot.id
        savedSpot.name = spot.name
        savedSpot.address = spot.address
        savedSpot.type = spot.type.rawValue
        savedSpot.latitude = spot.latitude
        savedSpot.longitude = spot.longitude
        savedSpot.rating = spot.rating
        savedSpot.hasWifi = spot.hasWifi
        savedSpot.hasPower = spot.hasPower
        savedSpot.noiseLevel = spot.noiseLevel.rawValue
        savedSpot.savedDate = Date()
        
        do {
            try container.viewContext.save()
            fetchSavedSpots()
            print("Spot saved: \(spot.name)")
        } catch {
            print("Error saving spot: \(error)")
        }
    }
    
    // Remove a saved spot
    func removeSpot(_ spot: SavedSpot) {
        container.viewContext.delete(spot)
        
        do {
            try container.viewContext.save()
            fetchSavedSpots()
            print("Spot removed")
        } catch {
            print("Error removing spot: \(error)")
        }
    }
    
    // Remove spot by StudySpot
    func removeSpot(_ spot: StudySpot) {
        let request: NSFetchRequest<SavedSpot> = SavedSpot.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", spot.id as CVarArg)
        
        do {
            let spots = try container.viewContext.fetch(request)
            if let savedSpot = spots.first {
                removeSpot(savedSpot)
            }
        } catch {
            print("Error finding spot to remove: \(error)")
        }
    }
    
    // Check if spot is saved
    func isSpotSaved(_ spot: StudySpot) -> Bool {
        let request: NSFetchRequest<SavedSpot> = SavedSpot.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", spot.id as CVarArg)
        
        do {
            let count = try container.viewContext.count(for: request)
            return count > 0
        } catch {
            print("Error checking if spot saved: \(error)")
            return false
        }
    }
    
    // Toggle favorite status
    func toggleFavorite(_ spot: StudySpot) {
        if isSpotSaved(spot) {
            removeSpot(spot)
        } else {
            saveSpot(spot)
        }
    }
    
    // Clear all saved spots
    func clearAllSavedSpots() {
        let request: NSFetchRequest<NSFetchRequestResult> = SavedSpot.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try container.viewContext.execute(deleteRequest)
            fetchSavedSpots()
            print("All saved spots cleared")
        } catch {
            print("Error clearing saved spots: \(error)")
        }
    }
}

// Extension to convert SavedSpot to StudySpot
extension SavedSpot {
    func toStudySpot() -> StudySpot {
        StudySpot(
            name: name ?? "Unknown",
            address: address ?? "",
            type: SpotType(rawValue: type ?? "cafe") ?? .cafe,
            latitude: latitude,
            longitude: longitude,
            hasWifi: hasWifi,
            hasPower: hasPower,
            hasParking: false,
            isAccessible: true,
            noiseLevel: NoiseLevel(rawValue: noiseLevel ?? "moderate") ?? .moderate,
            rating: rating,
            reviewCount: 0,
            distance: nil,
            openTime: "9:00 AM",
            closeTime: "5:00 PM"
        )
    }
}
