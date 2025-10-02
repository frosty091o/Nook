//
//  ListView.swift
//  Nook
//
//  Created by Ethan on 29/9/2025.
//

import SwiftUI

struct ListView: View {
    @State private var searchText = ""
    @State private var selectedFilter = "All"
    
    let filters = ["All", "Cafe", "Library", "Park", "Co-working", "University"]
    let spots = StudySpot.samples
    
    var filteredSpots: [StudySpot] {
        let filtered = spots.filter { spot in
            (searchText.isEmpty || spot.name.localizedCaseInsensitiveContains(searchText)) &&
            (selectedFilter == "All" || spot.type.rawValue == selectedFilter)
        }
        return filtered.sorted { $0.distance ?? 0 < $1.distance ?? 0 }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.background
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Filter tabs
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(filters, id: \.self) { filter in
                                FilterTab(
                                    title: filter,
                                    isSelected: selectedFilter == filter
                                ) {
                                    selectedFilter = filter
                                }
                            }
                        }
                        .padding()
                    }
                    .background(.ultraThinMaterial)
                    
                    // List
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(filteredSpots) { spot in
                                NavigationLink(destination: SpotDetailView(spot: spot)) {
                                    SpotCard(spot: spot)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Study Spots")
            .searchable(text: $searchText, prompt: "Search spots")
        }
    }
}

// Filter tab button
struct FilterTab: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Theme.mainBlue : Theme.glassGray)
                .foregroundColor(isSelected ? .white : .primary)
                .clipShape(Capsule())
        }
    }
}

// Spot card
struct SpotCard: View {
    let spot: StudySpot
    
    var body: some View {
        VStack(spacing: 0) {
            // Main content
            HStack(alignment: .top, spacing: 12) {
                // Icon
                Image(systemName: spot.type.icon)
                    .font(.title2)
                    .foregroundColor(spot.type.color)
                    .frame(width: 44, height: 44)
                    .background(Theme.glassGray)
                    .clipShape(Circle())
                
                // Info
                VStack(alignment: .leading, spacing: 6) {
                    // Name and rating
                    HStack {
                        Text(spot.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        HStack(spacing: 4) {
                            Image(systemName: "star.fill")
                                .font(.caption)
                                .foregroundColor(.yellow)
                            Text("\(spot.rating, specifier: "%.1f")")
                                .font(.caption)
                                .fontWeight(.medium)
                            Text("(\(spot.reviewCount))")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    // Type and distance
                    HStack {
                        Text(spot.type.rawValue)
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("•")
                            .foregroundColor(.secondary)
                        
                        Label("\(spot.distance ?? 0, specifier: "%.1f") km", systemImage: "location")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        if spot.isOpen {
                            Text("•")
                                .foregroundColor(.secondary)
                            Text("Open")
                                .font(.caption)
                                .foregroundColor(.green)
                        }
                    }
                    
                    // Address
                    Text(spot.address)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    // Amenities
                    HStack(spacing: 16) {
                        if spot.hasWifi {
                            HStack(spacing: 4) {
                                Image(systemName: "wifi")
                                Text("WiFi")
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                        }
                        
                        if spot.hasPower {
                            HStack(spacing: 4) {
                                Image(systemName: "bolt.fill")
                                Text("Power")
                            }
                            .font(.caption)
                            .foregroundColor(.orange)
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: spot.noiseLevel.icon)
                            Text(spot.noiseLevel.rawValue)
                        }
                        .font(.caption)
                        .foregroundColor(spot.noiseLevel.color)
                    }
                }
                
                // Favorite button
                Button(action: {}) {
                    Image(systemName: "heart")
                        .foregroundColor(.gray)
                }
            }
            .padding()
        }
        .glassCard()
    }
}

#Preview {
    ListView()
}
