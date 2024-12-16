//
//  ModelUser.swift
//  Cocktails9
//
//  Created by Mateja Mitic on 29.11.24..
//

import Foundation

struct User: Codable {
    var email: String
    var username: String
    var password: String
    var favoriteCocktails: [Drink]
    
}
