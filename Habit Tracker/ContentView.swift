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
            // Company Logo at top center
            Image("CompanyLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .padding(.top, 40)
            
            // Welcome Section
            VStack(spacing: 8) {
                Text("Hi User!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(todayDateString())
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 20)
            
            Spacer()
        }
    }
    
    // Helper function to format today's date
    func todayDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long  // e.g., "October 9, 2025"
        formatter.timeStyle = .none
        return formatter.string(from: Date())
    }
}

#Preview {
    ContentView()
}

