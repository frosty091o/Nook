//
//  RootTabView.swift
//  Nook
//
//  Created by Ethan on 1/10/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    // Sydney default location
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: -33.8688,
            longitude: 151.2093
        ),
        span: MKCoordinateSpan(
            latitudeDelta: 0.05,
            longitudeDelta: 0.05
        )
    )
    
    @State private var showingFilters = false
    @State private var selectedSpot: StudySpot?
    
    let spots = StudySpot.samples
    
    var body: some View {
        NavigationView {
            ZStack {
                // Map
                Map(coordinateRegion: $region,
                    annotationItems: spots) { spot in
                    MapAnnotation(coordinate: spot.coordinate) {
                        SpotAnnotation(spot: spot) {
                            selectedSpot = spot
                        }
                    }
                }
                .ignoresSafeArea(edges: .bottom)
                
                // Top controls
                VStack {
                    // Search bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        Text("Search for study spots...")
                            .foregroundColor(.gray)
                        Spacer()
                        
                        Button(action: {
                            showingFilters = true
                        }) {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(Theme.mainBlue)
                        }
                    }
                    .padding()
                    .glassCard()
                    .padding(.horizontal)
                    .padding(.top, 50)
                    
                    // Filter chips
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            FilterChip(title: "WiFi", icon: "wifi", isSelected: false)
                            FilterChip(title: "Quiet", icon: "speaker.slash", isSelected: false)
                            FilterChip(title: "Power", icon: "bolt", isSelected: false)
                            FilterChip(title: "Open Now", icon: "clock", isSelected: true)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                
                // Selected spot card
                if let spot = selectedSpot {
                    VStack {
                        Spacer()
                        SpotMapCard(spot: spot) {
                            selectedSpot = nil
                        }
                        .padding()
                        .transition(.move(edge: .bottom))
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Map annotation view
struct SpotAnnotation: View {
    let spot: StudySpot
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: spot.type.icon)
                .font(.caption)
                .foregroundColor(.white)
                .padding(8)
                .background(spot.type.color)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
                .shadow(radius: 4)
        }
    }
}

// Filter chip
struct FilterChip: View {
    let title: String
    let icon: String
    let isSelected: Bool
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
            Text(title)
                .font(.caption)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(isSelected ? Theme.mainBlue : Theme.glassWhite)
        .foregroundColor(isSelected ? .white : .primary)
        .clipShape(Capsule())
    }
}

// Spot card on map
struct SpotMapCard: View {
    let spot: StudySpot
    let onClose: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with close button
            HStack {
                Image(systemName: spot.type.icon)
                    .font(.title2)
                    .foregroundColor(spot.type.color)
                
                VStack(alignment: .leading) {
                    Text(spot.name)
                        .font(.headline)
                    Text(spot.type.rawValue)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: onClose) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
            
            // Info
            HStack {
                Label("\(spot.distance ?? 0, specifier: "%.1f") km", systemImage: "location")
                    .font(.caption)
                
                if spot.isOpen {
                    Label("Open", systemImage: "clock")
                        .font(.caption)
                        .foregroundColor(.green)
                } else {
                    Label("Closed", systemImage: "clock")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
                Spacer()
                
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                        .foregroundColor(.yellow)
                    Text("\(spot.rating, specifier: "%.1f")")
                        .font(.caption)
                }
            }
            
            // Amenities
            HStack(spacing: 16) {
                if spot.hasWifi {
                    Image(systemName: "wifi")
                        .foregroundColor(.blue)
                }
                if spot.hasPower {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.orange)
                }
                Image(systemName: spot.noiseLevel.icon)
                    .foregroundColor(spot.noiseLevel.color)
            }
            .font(.caption)
            
            // Actions
            HStack(spacing: 12) {
                Button(action: {}) {
                    Label("Directions", systemImage: "arrow.triangle.turn.up.right.circle")
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Button(action: {}) {
                    Label("Save", systemImage: "heart")
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .glassCard()
    }
}

#Preview {
    MapView()
}
