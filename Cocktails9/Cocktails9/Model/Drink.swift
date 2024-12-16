//
//  Cocktail.swift
//  Cocktails9
//
//  Created by Mateja Mitic on 2.12.24..
//

import Foundation

struct DrinkResponse: Codable {
    let drinks: [Drink]
}

struct Drink: Codable, Identifiable {

    let id: String
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case imageUrl = "strDrinkThumb"
    }
    
    init(idDrink: String, strDrink: String, strDrinkThumb: String) {
        self.id = idDrink
        self.name = strDrink
        self.imageUrl = strDrinkThumb
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
    }

}
