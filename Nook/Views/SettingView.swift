//
//  SettingView.swift
//  Nook
//
//  Created by Ethan on 2/10/2025.
//

import SwiftUI

struct SettingsView: View {
    // UserDefaults settings
    @AppStorage("searchRadius") private var searchRadius = 5.0
    @AppStorage("showOpenOnly") private var showOpenOnly = false
    @AppStorage("wifiRequired") private var wifiRequired = false
    @AppStorage("powerRequired") private var powerRequired = false
    @AppStorage("quietPreferred") private var quietPreferred = true
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    
    @State private var showingAbout = false
    @State private var showingClearData = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Search preferences section
                        VStack(alignment: .leading, spacing: 16) {
                            Label("Search Preferences", systemImage: "magnifyingglass")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            VStack(spacing: 12) {
                                // Search radius
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text("Search Radius")
                                        Spacer()
                                        Text("\(Int(searchRadius)) km")
                                            .foregroundColor(Theme.mainBlue)
                                            .fontWeight(.medium)
                                    }
                                    
                                    Slider(value: $searchRadius, in: 1...20, step: 1)
                                        .tint(Theme.mainBlue)
                                    
                                    HStack {
                                        Text("1 km")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                        Text("20 km")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                                .padding()
                                .glassCard()
                            }
                            .padding(.horizontal)
                        }
                        
                        // Filter preferences
                        VStack(alignment: .leading, spacing: 16) {
                            Label("Default Filters", systemImage: "slider.horizontal.3")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            VStack(spacing: 0) {
                                SettingToggle(
                                    icon: "clock",
                                    title: "Open Places Only",
                                    subtitle: "Show only currently open spots",
                                    isOn: $showOpenOnly
                                )
                                
                                Divider()
                                    .padding(.horizontal)
                                
                                SettingToggle(
                                    icon: "wifi",
                                    title: "WiFi Required",
                                    subtitle: "Only show spots with WiFi",
                                    isOn: $wifiRequired
                                )
                                
                                Divider()
                                    .padding(.horizontal)
                                
                                SettingToggle(
                                    icon: "bolt",
                                    title: "Power Outlets Required",
                                    subtitle: "Only show spots with power",
                                    isOn: $powerRequired
                                )
                                
                                Divider()
                                    .padding(.horizontal)
                                
                                SettingToggle(
                                    icon: "speaker.slash",
                                    title: "Prefer Quiet Spots",
                                    subtitle: "Prioritize quiet study spaces",
                                    isOn: $quietPreferred
                                )
                            }
                            .glassCard()
                            .padding(.horizontal)
                        }
                        
                        // Notifications
                        VStack(alignment: .leading, spacing: 16) {
                            Label("Notifications", systemImage: "bell")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            SettingToggle(
                                icon: "bell.badge",
                                title: "Push Notifications",
                                subtitle: "Get updates about saved spots",
                                isOn: $notificationsEnabled
                            )
                            .glassCard()
                            .padding(.horizontal)
                        }
                        
                        // About section
                        VStack(alignment: .leading, spacing: 16) {
                            Label("About", systemImage: "info.circle")
                                .font(.headline)
                                .padding(.horizontal)
                            
                            VStack(spacing: 0) {
                                SettingRow(
                                    icon: "app.badge",
                                    title: "Version",
                                    value: "1.0.0"
                                )
                                
                                Divider()
                                    .padding(.horizontal)
                                
                                SettingRow(
                                    icon: "person",
                                    title: "Developer",
                                    value: "iOS Student"
                                )
                                
                                Divider()
                                    .padding(.horizontal)
                                
                                Button(action: { showingAbout = true }) {
                                    HStack {
                                        Image(systemName: "questionmark.circle")
                                            .foregroundColor(Theme.mainBlue)
                                        Text("Help & Support")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    .padding()
                                }
                            }
                            .glassCard()
                            .padding(.horizontal)
                        }
                        
                        // Data management
                        VStack(spacing: 12) {
                            Button(action: { showingClearData = true }) {
                                HStack {
                                    Image(systemName: "trash")
                                    Text("Clear Local Data")
                                }
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .glassCard()
                            }
                            
                            Text("This will remove all saved spots and preferences")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Settings")
            .alert("Clear Data?", isPresented: $showingClearData) {
                Button("Cancel", role: .cancel) {}
                Button("Clear", role: .destructive) {
                    // Will implement with CoreData
                    print("Clearing data...")
                }
            } message: {
                Text("This will delete all your saved spots and reset preferences.")
            }
        }
    }
}

// Setting toggle row
struct SettingToggle: View {
    let icon: String
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(Theme.mainBlue)
                    .frame(width: 24)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.subheadline)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .toggleStyle(SwitchToggleStyle(tint: Theme.mainBlue))
        .padding()
    }
}

// Setting info row
struct SettingRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Theme.mainBlue)
                .frame(width: 24)
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

#Preview {
    SettingsView()
}
