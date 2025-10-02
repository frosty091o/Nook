//
//  SpotDeatilView.swift
//  Nook
//
//  Created by Ethan on 2/10/2025.
//
//
//  SavedView.swift
//  Nook
//
//  Saved/favorite spots screen
//

//
//  SavedView.swift
//  Nook
//
//  Saved/favorite spots screen
//

import SwiftUI

struct SavedView: View {
    // Will connect to CoreData later
    @State private var savedSpots: [StudySpot] = []
    @State private var showingSort = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.background
                    .ignoresSafeArea()
                
                if savedSpots.isEmpty {
                    // Empty state
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
                        
                        Button(action: {}) {
                            Label("Browse Spots", systemImage: "magnifyingglass")
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(Theme.mainBlue)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }
                } else {
                    // Saved spots list
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            // Stats
                            HStack(spacing: 16) {
                                StatCard(
                                    icon: "heart.fill",
                                    value: "\(savedSpots.count)",
                                    label: "Saved",
                                    color: .red
                                )
                                
                                StatCard(
                                    icon: "star.fill",
                                    value: "4.5",
                                    label: "Avg Rating",
                                    color: .yellow
                                )
                                
                                StatCard(
                                    icon: "location.fill",
                                    value: "2.3",
                                    label: "Avg km",
                                    color: .blue
                                )
                            }
                            .padding(.horizontal)
                            
                            // Spots
                            VStack(spacing: 12) {
                                ForEach(savedSpots) { spot in
                                    SavedSpotCard(spot: spot)
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
                if !savedSpots.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showingSort = true }) {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                    }
                }
            }
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

// Saved spot card (compact version)
struct SavedSpotCard: View {
    let spot: StudySpot
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
                    Label("\(spot.distance ?? 0, specifier: "%.1f") km", systemImage: "location")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
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
            
            Button(action: {}) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .glassCard()
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .onTapGesture {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                isPressed = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    isPressed = false
                }
            }
        }
    }
}

#Preview {
    SavedView()
}
