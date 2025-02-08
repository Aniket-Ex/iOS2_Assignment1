//
//  AddExpenseView.swift
//  Expense Tracker
//
//  Created by Aniket Saxena on 2025-01-30.
//

import SwiftUI

struct AddExpenseView: View {
    // Access the presentation mode to dismiss the view
    @Environment(\.presentationMode) var presentationMode
    
    // ViewModel to manage expense data
    @ObservedObject var viewModel: ExpenseViewModel
    
    // State variables to hold user input
    @State private var amount = "" // Holds the expense amount as a string
    @State private var description = "" // Holds the expense description
    @State private var category: ExpenseCategory // Holds the selected category
    
    // Custom initializer to set the initial category based on the selected category from the main view
    init(viewModel: ExpenseViewModel, selectedCategory: ExpenseCategory) {
        self.viewModel = viewModel
        self._category = State(initialValue: selectedCategory) // Initialize the category state
    }
    
    var body: some View {
        NavigationView {
            Form {
                // TextField for entering the expense amount
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad) // Show a decimal pad for easier input
                
                // TextField for entering the expense description
                TextField("Description", text: $description)
                
                // Picker for selecting the expense category
                Picker("Category", selection: $category) {
                    // Loop through all categories except "All"
                    ForEach(ExpenseCategory.allCases.filter { $0 != .all }, id: \.self) { category in
                        Text(category.rawValue) // Display the category name
                            .tag(category) // Use the category itself as the tag
                    }
                }
            }
            .navigationTitle("Add Expense") // Set the navigation title
            .toolbar {
                // Cancel button to dismiss the view without saving
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss() // Dismiss the view
                    }
                }
                
                // Save button to add the expense and dismiss the view
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Validate input and add the expense
                        if let amountValue = Double(amount), !description.isEmpty {
                            viewModel.addExpense(amount: amountValue, description: description, category: category)
                            presentationMode.wrappedValue.dismiss() // Dismiss the view after saving
                        }
                    }
                }
            }
        }
    }
}
