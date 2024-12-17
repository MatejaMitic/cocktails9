import SwiftUI

struct FilterView: View {
    @State private var selectedAlcoholic: String? = nil
    @State private var selectedGlass: String? = nil
    @State private var selectedCategory: String? = nil
    @State private var selectedIngredients: String? = nil
    
    @State private var isFilterViewPresented = false
    @State private var filterTypeToPresent: String = "Alcoholic / Non-Alcoholic"

    // Closure to pass the updated filters back to DrinksGridView
    var applyFilters: ((String?, String?, String?, String?) -> Void)?

    var body: some View {
        NavigationStack {
            Form {
                // Alcoholic / Non-Alcoholic Section
                Section(header: Text("Alcoholic / Non-Alcoholic")) {
                    Button(action: {
                        filterTypeToPresent = "Alcoholic / Non-Alcoholic"
                        isFilterViewPresented.toggle()
                    }) {
                        Text(selectedAlcoholic ?? "Select Alcoholic Type")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                }

                // Glass Used Section
                Section(header: Text("Glass Used")) {
                    Button(action: {
                        filterTypeToPresent = "Glass Used"
                        isFilterViewPresented.toggle()
                    }) {
                        Text(selectedGlass ?? "Select Glass Type")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                }

                // Category Section
                Section(header: Text("Category")) {
                    Button(action: {
                        filterTypeToPresent = "Category"
                        isFilterViewPresented.toggle()
                    }) {
                        Text(selectedCategory ?? "Select Category")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                }

                // Ingredients Section
                Section(header: Text("Ingredients")) {
                    Button(action: {
                        filterTypeToPresent = "Ingredients"
                        isFilterViewPresented.toggle()
                    }) {
                        Text(selectedIngredients ?? "Select Ingredients")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            .navigationTitle("Filters")
            .sheet(isPresented: $isFilterViewPresented) {
                // Passing the applyFilters closure to FilterViewDetail
                FilterViewDetail(filterType: filterTypeToPresent ?? "") { selectedOption in
                    // Update the selected filter based on user choice
                    switch filterTypeToPresent {
                    case "Alcoholic / Non-Alcoholic":
                        selectedAlcoholic = selectedOption
                    case "Glass Used":
                        selectedGlass = selectedOption
                    case "Category":
                        selectedCategory = selectedOption
                    case "Ingredients":
                        selectedIngredients = selectedOption
                    default:
                        break
                    }
                    
                    // Apply filters and pass them back to DrinksGridView
                    applyFilters?(selectedAlcoholic, selectedGlass, selectedCategory, selectedIngredients)
                }
            }
        }
    }
}
