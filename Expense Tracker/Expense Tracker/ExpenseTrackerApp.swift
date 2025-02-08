//
//  Expense_TrackerApp.swift
//  Expense Tracker
//
//  Created by Aniket Saxena on 2025-01-30.
//

import SwiftUI

// Main entry point of the app
@main
struct ExpenseTrackerApp: App {
    
    // Initialize the ViewModel as a StateObject to manage app-wide state
    @StateObject private var viewModel = ExpenseViewModel()
    
    var body: some Scene {
        WindowGroup {
            // Set the root view of the app to ExpenseListView
            ExpenseListView()
                .environmentObject(viewModel) // Pass the ViewModel to the view hierarchy
        }
    }
}
