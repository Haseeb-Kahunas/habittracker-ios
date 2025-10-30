//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Haseeb Ahmed on 06/10/2025.
//

import SwiftUI

struct ContentView: View {
    // State: This tells SwiftUI to watch for changes and update the UI
    @State private var habits: [Habit] = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Logo at top
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                    .padding(.top, 40)
                
                // Welcome message
                Text("Welcome back!")
                    .font(.title)
                    .fontWeight(.bold)
                
                // Current date
                Text(formattedDate())
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Habits Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Daily Habits:")
                        .font(.headline)
                        .padding(.top, 20)
                    
                    // ForEach loops through each habit and creates a Toggle
                    ForEach(habits.indices, id: \.self) { index in
                        Toggle(isOn: $habits[index].isCompleted) {
                            Text(habits[index].name)
                                .strikethrough(habits[index].isCompleted, color: .gray)
                                .foregroundColor(habits[index].isCompleted ? .gray : .primary)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        .animation(.spring(response: 0.5, dampingFraction: 0.3), value: habits[index].isCompleted)
                    }
                }
                .padding(.horizontal, 30)
                
                // Version at bottom
                Text("Version \(appVersion())")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 30)
                    .padding(.bottom, 20)
            }
        }
        .onAppear {
            // Load habits when app opens
            loadHabits()
        }
        .onChange(of: habits) { oldValue, newValue in
            // Save habits whenever they change
            saveHabits()
        }
    }
    
    // MARK: - Persistence Functions
    
    /// Load habits from UserDefaults, or create default habits if none exist
    func loadHabits() {
        if let data = UserDefaults.standard.data(forKey: "savedHabits"),
           let decoded = try? JSONDecoder().decode([Habit].self, from: data) {
            // Found saved habits - load them!
            habits = decoded
            print("✅ Loaded \(decoded.count) habits from UserDefaults")
        } else {
            // No saved habits - create default ones
            habits = createDefaultHabits()
            print("🆕 Created default habits")
        }
    }
    
    /// Save current habits to UserDefaults
    func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "savedHabits")
            print("💾 Saved \(habits.count) habits to UserDefaults")
        }
    }
    
    /// Create the default list of habits
    func createDefaultHabits() -> [Habit] {
        return [
            Habit(id: UUID(), name: "Pray Fajr", isCompleted: false),
            Habit(id: UUID(), name: "Drink 2L water", isCompleted: false),
            Habit(id: UUID(), name: "Eat Bananas", isCompleted: false),
            Habit(id: UUID(), name: "Eat 6 eggs a day", isCompleted: false),
            Habit(id: UUID(), name: "Exercise 30 min", isCompleted: false),
            Habit(id: UUID(), name: "Pray Zohr", isCompleted: false),
            Habit(id: UUID(), name: "Meditate 10 min", isCompleted: false),
            Habit(id: UUID(), name: "Read 10 pages", isCompleted: false),
            Habit(id: UUID(), name: "Pray Asar", isCompleted: false),
            Habit(id: UUID(), name: "No junk food", isCompleted: false),
            Habit(id: UUID(), name: "Pray Maghrib", isCompleted: false),
            Habit(id: UUID(), name: "Eat Dinner with family", isCompleted: false),
            Habit(id: UUID(), name: "Pray Isha", isCompleted: false),
        ]
    }
    
    // MARK: - Helper Functions
    
    /// Format the current date as a long string
    func formattedDate() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: Date())
        }
        
        /// Get the app version from Info.plist
        func appVersion() -> String {
            return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
        }
    }

    // MARK: - Data Models

    /// Habit data structure - Codable allows saving to UserDefaults
    struct Habit: Identifiable, Codable, Equatable {
        let id: UUID
        var name: String
        var isCompleted: Bool
    }

    // MARK: - Custom Styles

    /// Custom checkbox style for Toggle
    struct CheckboxToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .font(.system(size: 24))
                    .foregroundColor(configuration.isOn ? .green : .gray)
                    .onTapGesture {
                        configuration.isOn.toggle()
                    }
                
                configuration.label
            }
        }
    }

    // MARK: - Preview

    #Preview {
        ContentView()
    }
