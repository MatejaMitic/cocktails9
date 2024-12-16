import SwiftUI

class CocktailDetailViewModel: ObservableObject {
    @Published var cocktail: Cocktail? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func fetchCocktailDetails(id: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedResponse = try JSONDecoder().decode(CocktailResponse.self, from: data)
                
                if let cocktail = decodedResponse.drinks?.first {
                    self.cocktail = cocktail
                } else {
                    self.errorMessage = "Cocktail details not found."
                }
            } catch {
                self.errorMessage = "Failed to load cocktail details."
            }
            isLoading = false
        }
    }
}

// Data models to decode the response
struct CocktailResponse: Codable {
    let drinks: [Cocktail]?
}

struct Cocktail: Codable, Identifiable {
    var id: String { strDrink }
    
    let strDrink: String
    let strDrinkThumb: String
    let strInstructions: String
    let strGlass: String?  // Glass type
    let strCategory: String?  // Category (e.g., "Alcoholic", "Non-Alcoholic")
    let strAlcoholic: String? // Alcoholic or Non-Alcoholic
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    
    // Combine ingredients and measures using map
    var ingredientsAndMeasures: [(ingredient: String, measure: String)] {
        // Arrays of ingredients and measures
        let ingredients = [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6,
            strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12,
            strIngredient13, strIngredient14, strIngredient15
        ]
        
        let measures = [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6,
            strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12,
            strMeasure13, strMeasure14, strMeasure15
        ]
        
        // Use zip to combine ingredients and measures, providing default empty string for nil values
        return zip(ingredients, measures).compactMap { ingredient, measure in
            guard let ingredient = ingredient, !ingredient.isEmpty else {
                return nil // Skip if the ingredient is nil or empty
            }
            let measureValue = measure ?? "" // Default empty string for nil measures
            return (ingredient, measureValue)
        }
    }
}
