//
//  SpotDetailView.swift
//  Nook
//
//  Created by Ethan on 2/10/2025.
//

import SwiftUI
import MapKit

struct SpotDetailView: View {
    let spot: StudySpot
    @EnvironmentObject var dataManager: DataManager
    @State private var isFavorite = false
    @State private var showingReviews = false
    @State private var showingDirections = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Map header
                ZStack(alignment: .topTrailing) {
                    MiniMapView(spot: spot)
                        .frame(height: 250)
                        .overlay(
                            LinearGradient(
                                colors: [.clear, Theme.background.opacity(0.3)],
                                startPoint: .center,
                                endPoint: .bottom
                            )
                        )
                    
                    // Close button
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.white, .gray)
                    }
                    .padding()
                }
                
                VStack(spacing: 24) {
                    // Main info
                    VStack(alignment: .leading, spacing: 16) {
                        // Header
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(spot.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                
                                HStack {
                                    Image(systemName: spot.type.icon)
                                    Text(spot.type.rawValue)
                                }
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            // Favorite button
                            Button(action: {
                                withAnimation {
                                    isFavorite.toggle()
                                    dataManager.toggleFavorite(spot)
                                }
                            }) {
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .font(.title2)
                                    .foregroundColor(isFavorite ? .red : .gray)
                                    .scaleEffect(isFavorite ? 1.1 : 1.0)
                            }
                        }
                        
                        // Rating
                        HStack {
                            ForEach(0..<5) { index in
                                Image(systemName: index < Int(spot.rating) ? "star.fill" : "star")
                                    .foregroundColor(.yellow)
                            }
                            Text(String(format: "%.1f", spot.rating))
                                .fontWeight(.semibold)
                            Text("(\(spot.reviewCount) reviews)")
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Button(action: { showingReviews = true }) {
                                Text("See all")
                                    .font(.caption)
                                    .foregroundColor(Theme.mainBlue)
                            }
                        }
                        .font(.subheadline)
                        
                        // Location info
                        VStack(alignment: .leading, spacing: 8) {
                            Label(spot.address, systemImage: "location.fill")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Label("\(spot.distance ?? 0, specifier: "%.1f") km away",
                                      systemImage: "figure.walk")
                                    .font(.caption)
                                
                                Text("•")
                                
                                Label("\(Int((spot.distance ?? 0) * 12)) min walk",
                                      systemImage: "clock")
                                    .font(.caption)
                            }
                            .foregroundColor(.secondary)
                        }
                        
                        // Hours
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(spot.isOpen ? .green : .red)
                            Text(spot.isOpen ? "Open" : "Closed")
                                .foregroundColor(spot.isOpen ? .green : .red)
                                .fontWeight(.medium)
                            Text("• \(spot.openTime) - \(spot.closeTime)")
                                .foregroundColor(.secondary)
                        }
                        .font(.subheadline)
                    }
                    .padding()
                    .glassCard()
                    
                    // Amenities
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Amenities")
                            .font(.headline)
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())],
                                  spacing: 12) {
                            AmenityItem(
                                icon: "wifi",
                                title: "WiFi",
                                available: spot.hasWifi
                            )
                            AmenityItem(
                                icon: "bolt.fill",
                                title: "Power Outlets",
                                available: spot.hasPower
                            )
                            AmenityItem(
                                icon: "car.fill",
                                title: "Parking",
                                available: spot.hasParking
                            )
                            AmenityItem(
                                icon: "figure.roll",
                                title: "Accessible",
                                available: spot.isAccessible
                            )
                        }
                        
                        // Noise level
                        HStack {
                            Image(systemName: spot.noiseLevel.icon)
                                .font(.title3)
                                .foregroundColor(spot.noiseLevel.color)
                                .frame(width: 40, height: 40)
                                .background(Theme.glassGray)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text("Noise Level")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(spot.noiseLevel.rawValue)
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .smallGlassCard()
                    }
                    .padding()
                    .glassCard()
                    
                    // Action buttons
                    HStack(spacing: 12) {
                        Button(action: { showingDirections = true }) {
                            Label("Get Directions", systemImage: "location.arrow")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)
                        
                        Button(action: {}) {
                            Label("Write Review", systemImage: "star")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                    }
                    .padding(.horizontal)
                    
                    // Tips
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Tips")
                            .font(.headline)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            TipRow(text: "Best seats are near the windows")
                            TipRow(text: "Gets busy after 3pm on weekdays")
                            TipRow(text: "Free WiFi password: study2024")
                        }
                    }
                    .padding()
                    .glassCard()
                }
                .padding()
                .offset(y: -20)
            }
        }
        .ignoresSafeArea(edges: .top)
        .navigationBarHidden(true)
        .onAppear {
            isFavorite = dataManager.isSpotSaved(spot)
        }
    }
}

// Mini map view - Updated for iOS 17
struct MiniMapView: View {
    let spot: StudySpot
    @State private var position: MapCameraPosition
    
    init(spot: StudySpot) {
        self.spot = spot
        self._position = State(initialValue: .region(
            MKCoordinateRegion(
                center: spot.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        ))
    }
    
    var body: some View {
        Map(position: $position) {
            Marker(spot.name, coordinate: spot.coordinate)
                .tint(spot.type.color)
        }
        .mapStyle(.standard)
        .disabled(true)
    }
}

// Amenity item
struct AmenityItem: View {
    let icon: String
    let title: String
    let available: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(available ? Theme.mainBlue : .gray)
            Text(title)
                .font(.subheadline)
                .foregroundColor(available ? .primary : .secondary)
            Spacer()
            Image(systemName: available ? "checkmark.circle.fill" : "xmark.circle")
                .foregroundColor(available ? .green : .gray)
        }
        .padding()
        .smallGlassCard()
    }
}

// Tip row
struct TipRow: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "lightbulb.fill")
                .foregroundColor(.yellow)
                .font(.caption)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    SpotDetailView(spot: StudySpot.samples[0])
        .environmentObject(DataManager())
}
