//
//  ExpenseViewModel.swift
//  Expense Tracker
//
//  Created by Aniket Saxena on 2025-01-30.
//

import SwiftUI

// MARK: - ExpenseViewModel with Persistence

class ExpenseViewModel: ObservableObject {
    // Published property to hold the list of expenses
    // Automatically saves expenses to UserDefaults whenever the list changes
    @Published var expenses: [Expense] = [] {
        didSet {
            saveExpenses() // Save expenses whenever the list is updated
        }
    }
    
    // Published property to track the currently selected category for filtering
    @Published var selectedCategory: ExpenseCategory = .all
    
    // List of all available expense categories
    let categories = ExpenseCategory.allCases
    
    // Initialize the ViewModel and load saved expenses from UserDefaults
    init() {
        loadExpenses()
    }
    
    // Function to add a new expense
    func addExpense(amount: Double, description: String, category: ExpenseCategory) {
        let newExpense = Expense(amount: amount, description: description, category: category)
        expenses.append(newExpense) // Add the new expense to the list
    }
    
    // Function to delete an expense at the specified offsets
    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets) // Remove the expense from the array
        saveExpenses() // Save the updated list to UserDefaults
    }
    
    // Function to calculate the total expense amount
    // If a category is selected, it calculates the total for that category only
    func totalExpense() -> Double {
        let filteredExpenses = selectedCategory == .all ? expenses : expenses.filter { $0.category == selectedCategory }
        return filteredExpenses.reduce(0) { $0 + $1.amount } // Sum up the amounts
    }
    
    // Function to save expenses to UserDefaults
    private func saveExpenses() {
        if let encoded = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(encoded, forKey: "expenses") // Save encoded data
        }
    }
    
    // Function to load expenses from UserDefaults
    private func loadExpenses() {
        if let savedData = UserDefaults.standard.data(forKey: "expenses"),
           let decoded = try? JSONDecoder().decode([Expense].self, from: savedData) {
            expenses = decoded // Load and decode saved data
        }
    }
}
