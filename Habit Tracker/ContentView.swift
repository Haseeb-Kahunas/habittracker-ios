//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Haseeb Ahmed on 06/10/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            // Company Logo at top center (using SF Symbol)
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .foregroundStyle(.green)
                .padding(.top, 40)
            
            // Welcome Section with time-based greeting
            VStack(spacing: 8) {
                Text(timeBasedGreeting())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(todayDateString())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 20)
            
            // Spacer pushes version to bottom
            Spacer()
            
            // Version label at bottom
            Text(appVersion())
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.bottom, 20)
        }
    }
    
    // Time-based greeting function
    func timeBasedGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 0..<12:
            return "Good Morning, Haseeb!"
        case 12..<17:
            return "Good Afternoon, Haseeb!"
        case 17..<22:
            return "Good Evening, Haseeb!"
        default:
            return "Good Night, Haseeb!"
        }
    }
    
    // Helper function to format today's date
    func todayDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: Date())
    }
    
    // Auto-synced version number from Bundle
    func appVersion() -> String {
        let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
        return "v\(version)"
    }
}

#Preview {
    ContentView()
}
