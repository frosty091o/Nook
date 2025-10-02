//
//  Untitled.swift
//  Nook
//
//  Created by Ethan on 1/10/2025.
//
//


import Foundation
import CoreLocation
import SwiftUI

struct StudySpot: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let type: SpotType
    let latitude: Double
    let longitude: Double
    
    // Amenities
    let hasWifi: Bool
    let hasPower: Bool
    let hasParking: Bool
    let isAccessible: Bool
    
    // Details
    let noiseLevel: NoiseLevel
    let rating: Double
    let reviewCount: Int
    let distance: Double? // in km
    
    // Hours (simplified)
    let openTime: String
    let closeTime: String
    
    // Computed properties
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var isOpen: Bool {
        // Simplified - just returns true for now
        // Will implement proper time checking later
        return true
    }
}

// Spot types
enum SpotType: String, CaseIterable {
    case cafe = "Cafe"
    case library = "Library"
    case park = "Park"
    case coworking = "Co-working"
    case university = "University"
    
    var icon: String {
        switch self {
        case .cafe: return "cup.and.saucer"
        case .library: return "books.vertical"
        case .park: return "leaf"
        case .coworking: return "desktopcomputer"
        case .university: return "graduationcap"
        }
    }
    
    var color: Color {
        switch self {
        case .cafe: return .brown
        case .library: return .blue
        case .park: return .green
        case .coworking: return .purple
        case .university: return .orange
        }
    }
}

// Noise levels
enum NoiseLevel: String, CaseIterable {
    case silent = "Silent"
    case quiet = "Quiet"
    case moderate = "Moderate"
    case busy = "Busy"
    
    var icon: String {
        switch self {
        case .silent: return "speaker.slash"
        case .quiet: return "speaker.wave.1"
        case .moderate: return "speaker.wave.2"
        case .busy: return "speaker.wave.3"
        }
    }
    
    var color: Color {
        switch self {
        case .silent: return .green
        case .quiet: return .mint
        case .moderate: return .orange
        case .busy: return .red
        }
    }
}

// Sample data for testing
extension StudySpot {
    static let samples = [
        StudySpot(
            name: "State Library",
            address: "1 Shakespeare Pl, Sydney NSW 2000",
            type: .library,
            latitude: -33.8688,
            longitude: 151.2093,
            hasWifi: true,
            hasPower: true,
            hasParking: false,
            isAccessible: true,
            noiseLevel: .quiet,
            rating: 4.8,
            reviewCount: 342,
            distance: 0.5,
            openTime: "9:00 AM",
            closeTime: "8:00 PM"
        ),
        StudySpot(
            name: "The Grounds Coffee",
            address: "Building 7A, Sydney NSW 2015",
            type: .cafe,
            latitude: -33.8850,
            longitude: 151.1930,
            hasWifi: true,
            hasPower: true,
            hasParking: true,
            isAccessible: true,
            noiseLevel: .moderate,
            rating: 4.5,
            reviewCount: 892,
            distance: 2.3,
            openTime: "7:00 AM",
            closeTime: "4:00 PM"
        ),
        StudySpot(
            name: "Hyde Park",
            address: "Elizabeth St, Sydney NSW 2000",
            type: .park,
            latitude: -33.8734,
            longitude: 151.2113,
            hasWifi: false,
            hasPower: false,
            hasParking: false,
            isAccessible: true,
            noiseLevel: .quiet,
            rating: 4.2,
            reviewCount: 156,
            distance: 1.2,
            openTime: "24 Hours",
            closeTime: "24 Hours"
        ),
        StudySpot(
            name: "WeWork Coworking",
            address: "5 Martin Pl, Sydney NSW 2000",
            type: .coworking,
            latitude: -33.8678,
            longitude: 151.2073,
            hasWifi: true,
            hasPower: true,
            hasParking: false,
            isAccessible: true,
            noiseLevel: .quiet,
            rating: 4.6,
            reviewCount: 234,
            distance: 0.8,
            openTime: "8:00 AM",
            closeTime: "9:00 PM"
        ),
        StudySpot(
            name: "UTS Library",
            address: "15 Broadway, Ultimo NSW 2007",
            type: .university,
            latitude: -33.8832,
            longitude: 151.2005,
            hasWifi: true,
            hasPower: true,
            hasParking: false,
            isAccessible: true,
            noiseLevel: .silent,
            rating: 4.7,
            reviewCount: 567,
            distance: 1.5,
            openTime: "8:00 AM",
            closeTime: "10:00 PM"
        )
    ]
}

