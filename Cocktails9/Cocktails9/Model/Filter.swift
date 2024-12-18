import Foundation

// Response model for filter lists (categories, glasses, ingredients, etc.)
struct FilterResponse: Codable {
    var drinks: [FilterOption]?
}

// Represents each filter option (e.g., category, glass, ingredient, alcohol type)
struct FilterOption: Codable {
    var name: String
}
