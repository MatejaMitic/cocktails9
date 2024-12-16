import SwiftUI

struct FilterView: View {
    @Binding var isFiltering: Bool  // Binding to close the filter view
    @Binding var selectedAlcoholType: String?
    @Binding var selectedCategory: String?
    @Binding var selectedGlass: String?
    @Binding var selectedIngredient: String?

    // Mock data for filter options
    private let alcoholTypes = ["Alcoholic", "Non_Alcoholic"]
    private let categories = ["Cocktail", "Shot", "Punch", "Mocktail"]
    private let glasses = ["Highball", "Cocktail Glass", "Wine Glass", "Shot Glass"]
    private let ingredients = ["Rum", "Vodka", "Lime", "Mint", "Sugar"]

    var body: some View {
        NavigationStack {
            VStack {
                // Alcoholic Filter
                Section(header: Text("Alcoholic").font(.headline)) {
                    ForEach(alcoholTypes, id: \.self) { alcohol in
                        Button(action: {
                            selectedAlcoholType = (selectedAlcoholType == alcohol) ? nil : alcohol
                        }) {
                            Text(alcohol)
                                .padding()
                                .background(selectedAlcoholType == alcohol ? Color.blue : Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.primary)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }

                // Category Filter
                Section(header: Text("Category").font(.headline)) {
                    ForEach(categories, id: \.self) { category in
                        Button(action: {
                            selectedCategory = (selectedCategory == category) ? nil : category
                        }) {
                            Text(category)
                                .padding()
                                .background(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.primary)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }

                // Glass Filter
                Section(header: Text("Glass").font(.headline)) {
                    ForEach(glasses, id: \.self) { glass in
                        Button(action: {
                            selectedGlass = (selectedGlass == glass) ? nil : glass
                        }) {
                            Text(glass)
                                .padding()
                                .background(selectedGlass == glass ? Color.blue : Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.primary)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }

                // Ingredients Filter
                Section(header: Text("Ingredients").font(.headline)) {
                    ForEach(ingredients, id: \.self) { ingredient in
                        Button(action: {
                            selectedIngredient = (selectedIngredient == ingredient) ? nil : ingredient
                        }) {
                            Text(ingredient)
                                .padding()
                                .background(selectedIngredient == ingredient ? Color.blue : Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.primary)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }

                // Close Filter View Button
                Button("Close Filter") {
                    isFiltering = false
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
        }
    }
}

#Preview {
    FilterView(
        isFiltering: .constant(true),
        selectedAlcoholType: .constant(nil),
        selectedCategory: .constant(nil),
        selectedGlass: .constant(nil),
        selectedIngredient: .constant(nil)
    )
}
