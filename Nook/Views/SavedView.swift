//
//  SavedView.swift
//  Nook
//
//  Created by Ethan on 2/10/2025.
//

//
//  SavedView.swift
//  Nook
//
//  Saved spots with Core Data
//

import SwiftUI
import CoreData

struct SavedView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var showingSort = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.background
                    .ignoresSafeArea()
                
                if dataManager.savedSpots.isEmpty {
                    // Empty state
                    EmptyStateView()
                } else {
                    // Saved spots list
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            // Stats
                            StatsRow(spots: dataManager.savedSpots)
                                .padding(.horizontal)
                            
                            // Spots
                            VStack(spacing: 12) {
                                ForEach(dataManager.savedSpots) { savedSpot in
                                    SavedSpotCard(
                                        spot: savedSpot.toStudySpot(),
                                        onRemove: {
                                            dataManager.removeSpot(savedSpot)
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Saved Spots")
            .toolbar {
                if !dataManager.savedSpots.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: sortByDistance) {
                                Label("Sort by Distance", systemImage: "location")
                            }
                            Button(action: sortByRating) {
                                Label("Sort by Rating", systemImage: "star")
                            }
                            Button(action: sortByDate) {
                                Label("Sort by Date Added", systemImage: "calendar")
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                    }
                }
            }
        }
        .onAppear {
            dataManager.fetchSavedSpots()
        }
    }
    
    func sortByDistance() {
        // Will implement when we have location
        print("Sort by distance")
    }
    
    func sortByRating() {
        dataManager.savedSpots.sort { $0.rating > $1.rating }
    }
    
    func sortByDate() {
        dataManager.savedSpots.sort {
            ($0.savedDate ?? Date()) > ($1.savedDate ?? Date())
        }
    }
}

// Empty state view
struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: "heart.circle")
                .font(.system(size: 80))
                .foregroundStyle(
                    LinearGradient(
                        colors: [Theme.mainBlue, Theme.lightBlue],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            VStack(spacing: 12) {
                Text("No Saved Spots Yet")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Tap the heart icon on any study spot to save it for quick access")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 280)
            }
            
            NavigationLink(destination: ListView()) {
                Label("Browse Spots", systemImage: "magnifyingglass")
                    .padding(.horizontal, 24)
                    .padding(.vertical, 12)
                    .background(Theme.mainBlue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
        }
    }
}

// Stats row
struct StatsRow: View {
    let spots: [SavedSpot]
    
    var averageRating: Double {
        guard !spots.isEmpty else { return 0 }
        let sum = spots.reduce(0) { $0 + $1.rating }
        return sum / Double(spots.count)
    }
    
    var body: some View {
        HStack(spacing: 16) {
            StatCard(
                icon: "heart.fill",
                value: "\(spots.count)",
                label: "Saved",
                color: .red
            )
            
            StatCard(
                icon: "star.fill",
                value: String(format: "%.1f", averageRating),
                label: "Avg Rating",
                color: .yellow
            )
            
            StatCard(
                icon: "wifi",
                value: "\(spots.filter { $0.hasWifi }.count)",
                label: "With WiFi",
                color: .blue
            )
        }
    }
}

// Stat card
struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.title3)
                .fontWeight(.bold)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .smallGlassCard()
    }
}

// Updated saved spot card
struct SavedSpotCard: View {
    let spot: StudySpot
    let onRemove: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        HStack(spacing: 12) {
            // Type icon
            Image(systemName: spot.type.icon)
                .font(.title3)
                .foregroundColor(spot.type.color)
                .frame(width: 36, height: 36)
                .background(Theme.glassGray)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(spot.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                HStack(spacing: 8) {
                    if let distance = spot.distance {
                        Label("\(distance, specifier: "%.1f") km", systemImage: "location")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    HStack(spacing: 2) {
                        Image(systemName: "star.fill")
                            .font(.caption2)
                            .foregroundColor(.yellow)
                        Text("\(spot.rating, specifier: "%.1f")")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            
            Spacer()
            
            Button(action: onRemove) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .scaleEffect(isPressed ? 0.8 : 1.0)
            }
            .onTapGesture {
                withAnimation(.spring(response: 0.3)) {
                    isPressed = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isPressed = false
                        onRemove()
                    }
                }
            }
        }
        .padding()
        .glassCard()
    }
}

#Preview {
    SavedView()
        .environmentObject(DataManager())
}
