//
//  Expense.swift
//  Expense Tracker
//
//  Created by Aniket Saxena on 2025-01-30.
//

import SwiftUI
import Foundation

// MARK: - Expense Model with Enum for Type Safety

// Enum to represent different categories of expenses
enum ExpenseCategory: String, CaseIterable, Codable {
    case all = "All"       // Represents all categories (used for filtering)
    case food = "Food"     // Represents food-related expenses
    case travel = "Travel" // Represents travel-related expenses
    case bills = "Bills"   // Represents bill-related expenses
}

// Struct to represent an individual expense
struct Expense: Identifiable, Codable {
    let id: UUID           // Unique identifier for each expense
    var amount: Double     // The amount of the expense
    var description: String // A brief description of the expense
    var category: ExpenseCategory // The category of the expense (e.g., Food, Travel, Bills)
    
    // Custom initializer with default values
    init(id: UUID = UUID(), amount: Double, description: String, category: ExpenseCategory) {
        self.id = id
        self.amount = amount
        self.description = description
        self.category = category
    }
}
