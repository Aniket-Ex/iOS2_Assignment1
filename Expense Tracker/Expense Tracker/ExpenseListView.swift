//
//  ExpenseListView.swift
//  Expense Tracker
//
//  Created by Aniket Saxena on 2025-01-30.
//

import SwiftUI

struct ExpenseListView: View {
    // StateObject to manage the ViewModel for this view
    @StateObject private var viewModel = ExpenseViewModel()
    
    // State variable to control the visibility of the "Add Expense" sheet
    @State private var showAddExpense = false
    
    // Computed property to filter expenses based on the selected category
    var filteredExpenses: [Expense] {
        viewModel.selectedCategory == .all ? viewModel.expenses : viewModel.expenses.filter { $0.category == viewModel.selectedCategory }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Picker to select the expense category for filtering
                Picker("Category", selection: $viewModel.selectedCategory) {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Text(category.rawValue) // Display the category name
                            .tag(category) // Use the category itself as the tag
                    }
                }
                .pickerStyle(SegmentedPickerStyle()) // Use a segmented picker style
                .padding() // Add padding around the picker
                
                // List to display filtered expenses
                List {
                    ForEach(filteredExpenses) { expense in
                        HStack {
                            VStack(alignment: .leading) {
                                // Display the expense description
                                Text(expense.description)
                                    .font(.headline)
                                // Display the expense category
                                Text(expense.category.rawValue)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            // Display the expense amount formatted to 2 decimal places
                            Text("$\(expense.amount, specifier: "%.2f")")
                        }
                    }
                    .onDelete(perform: deleteExpense) // Enable swipe-to-delete functionality
                }
                
                // Display the total expense amount
                Text("Total: $\(viewModel.totalExpense(), specifier: "%.2f")")
                    .font(.title2)
                    .padding()
                
                // Button to show the "Add Expense" sheet
                Button("Add Expense") {
                    showAddExpense = true
                }
                .padding()
                .sheet(isPresented: $showAddExpense) {
                    // Present the AddExpenseView with the current selected category
                    AddExpenseView(viewModel: viewModel, selectedCategory: viewModel.selectedCategory)
                }
            }
            .navigationTitle(Text("Expense Tracker")) // Set the navigation title
        }
    }
    
    // Function to handle deleting expenses
    private func deleteExpense(at offsets: IndexSet) {
        viewModel.deleteExpense(at: offsets) // Call the deleteExpense method in the ViewModel
    }
}   
