//
//  FilterModel.swift
//  Cocktails9
//
//  Created by Mateja Mitic on 16.12.24..
//

import Foundation

// Response model for filter lists (categories, glasses, ingredients, etc.)
struct FilterResponse: Codable {
    var drinks: [FilterOption]?
}

// Represents each filter option (e.g., category, glass, ingredient, alcohol type)
struct FilterOption: Codable {
    var name: String
}

