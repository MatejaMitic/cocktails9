import Foundation

struct DrinkDetailsResponse: Codable {
    let drinks: [DrinkDetails]?
}

struct DrinkDetails: Codable, Identifiable {
    var id: String { drink }
    
    let drink: String  // strDrink -> drink
    let drinkThumb: String  // strDrinkThumb -> drinkThumb
    let instructions: String  // strInstructions -> instructions
    let glass: String?  // strGlass -> glass
    let category: String?  // strCategory -> category
    let alcoholic: String?  // strAlcoholic -> alcoholic
    let ingredient1: String?  // strIngredient1 -> ingredient1
    let ingredient2: String?  // strIngredient2 -> ingredient2
    let ingredient3: String?  // strIngredient3 -> ingredient3
    let ingredient4: String?  // strIngredient4 -> ingredient4
    let ingredient5: String?  // strIngredient5 -> ingredient5
    let ingredient6: String?  // strIngredient6 -> ingredient6
    let ingredient7: String?  // strIngredient7 -> ingredient7
    let ingredient8: String?  // strIngredient8 -> ingredient8
    let ingredient9: String?  // strIngredient9 -> ingredient9
    let ingredient10: String?  // strIngredient10 -> ingredient10
    let ingredient11: String?  // strIngredient11 -> ingredient11
    let ingredient12: String?  // strIngredient12 -> ingredient12
    let ingredient13: String?  // strIngredient13 -> ingredient13
    let ingredient14: String?  // strIngredient14 -> ingredient14
    let ingredient15: String?  // strIngredient15 -> ingredient15
    
    let measure1: String?  // strMeasure1 -> measure1
    let measure2: String?  // strMeasure2 -> measure2
    let measure3: String?  // strMeasure3 -> measure3
    let measure4: String?  // strMeasure4 -> measure4
    let measure5: String?  // strMeasure5 -> measure5
    let measure6: String?  // strMeasure6 -> measure6
    let measure7: String?  // strMeasure7 -> measure7
    let measure8: String?  // strMeasure8 -> measure8
    let measure9: String?  // strMeasure9 -> measure9
    let measure10: String?  // strMeasure10 -> measure10
    let measure11: String?  // strMeasure11 -> measure11
    let measure12: String?  // strMeasure12 -> measure12
    let measure13: String?  // strMeasure13 -> measure13
    let measure14: String?  // strMeasure14 -> measure14
    let measure15: String?  // strMeasure15 -> measure15
    
    // Combine ingredients and measures using map
    var ingredientsAndMeasures: [(ingredient: String, measure: String)] {
        // Arrays of ingredients and measures
        let ingredients = [
            ingredient1, ingredient2, ingredient3, ingredient4, ingredient5, ingredient6,
            ingredient7, ingredient8, ingredient9, ingredient10, ingredient11, ingredient12,
            ingredient13, ingredient14, ingredient15
        ]
        
        let measures = [
            measure1, measure2, measure3, measure4, measure5, measure6,
            measure7, measure8, measure9, measure10, measure11, measure12,
            measure13, measure14, measure15
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
    
    // Coding keys to map JSON keys to custom Swift property names
    enum CodingKeys: String, CodingKey {
        case drink = "strDrink"
        case drinkThumb = "strDrinkThumb"
        case instructions = "strInstructions"
        case glass = "strGlass"
        case category = "strCategory"
        case alcoholic = "strAlcoholic"
        
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
    }
}
