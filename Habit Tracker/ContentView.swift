//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Haseeb Ahmed on 06/10/2025.
//

import SwiftUI

struct ContentView: View {
    // State: This tells SwiftUI to watch for changes and update the UI
    @State private var habits = [
        Habit(name: "Pray Fajr", isCompleted: false),
        Habit(name: "Drink 2L water", isCompleted: false),
        Habit(name: "Eat Bananas", isCompleted: false),
        Habit(name: "Eat 6 eggs a day", isCompleted: false),
        Habit(name: "Exercise 30 min", isCompleted: false),
        Habit(name: "Pray Zohr", isCompleted: false),
        Habit(name: "Meditate 10 min", isCompleted: false),
        Habit(name: "Read 10 pages", isCompleted: false),
        Habit(name: "Pray Asar", isCompleted: false),
        Habit(name: "No junk food", isCompleted: false),
        Habit(name: "Pray Maghrib", isCompleted: false),
        Habit(name: "Eat Dinner with family", isCompleted: false),
        Habit(name: "Pray Isha", isCompleted: false),
    ]
    
    var body: some View {
        ScrollView {  // ← ADD THIS!
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
                    }
                }
                .padding(.horizontal, 30)
                
                // Version at bottom (removed Spacer, ScrollView handles it)
                Text("Version \(appVersion())")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.top, 30)
                    .padding(.bottom, 20)
            }
        } // ← CLOSE ScrollView here
    }
    
    // Helper function to format date
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }
    
    // Helper function to get app version
    func appVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
}

// Habit data structure
struct Habit: Identifiable {
    let id = UUID()
    var name: String
    var isCompleted: Bool
}

// Custom checkbox style for Toggle
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

#Preview {
    ContentView()
}
