import SwiftUI

enum FilterType: String, Identifiable {
    var id: String { self.rawValue }

    case alcoholic = "Alcoholic / Non-Alcoholic"
    case ingredients = "Ingredients"
    case glass = "Glass Used"
    case category = "Category"
}

struct FilterView: View {
    @State private var selectedAlcoholic: String? = nil
    @State private var selectedGlass: String? = nil
    @State private var selectedCategory: String? = nil
    @State private var selectedIngredients: String? = nil
    
    @State private var filterTypeToPresent: FilterType?

    // Closure to pass the updated filters back to DrinksGridView
    var applyFilters: ((String?, String?, String?, String?) -> Void)?

    var body: some View {
        NavigationStack {
            Form {
                // Alcoholic / Non-Alcoholic Section
                Section(header: Text("Alcoholic / Non-Alcoholic")) {
                    Button {
                        filterTypeToPresent = .alcoholic
                    } label: {
                        Text(selectedAlcoholic ?? "Select Alcoholic Type")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                }

                // Glass Used Section
                Section(header: Text("Glass Used")) {
                    Button(action: {
                        filterTypeToPresent = .glass
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
                        filterTypeToPresent = .category
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
                        filterTypeToPresent = .ingredients
                    }) {
                        Text(selectedIngredients ?? "Select Ingredients")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            .navigationTitle("Filters")
            .sheet(item: $filterTypeToPresent, content: { filterType in
                FilterViewDetail(filterType: filterType.rawValue) { selectedOption in
                    // Update the selected filter based on user choice
                    switch filterType {
                    case .alcoholic:
                        selectedAlcoholic = selectedOption
                    case .glass:
                        selectedGlass = selectedOption
                    case .category:
                        selectedCategory = selectedOption
                    case .ingredients:
                        selectedIngredients = selectedOption
                    }

                    // Apply filters and pass them back to DrinksGridView
                    applyFilters?(selectedAlcoholic, selectedGlass, selectedCategory, selectedIngredients)
                }
            })
        }
        .background(Color.green.opacity(0.2).edgesIgnoringSafeArea(.all)) // Apply green background with opacity 0.2
    }
}

