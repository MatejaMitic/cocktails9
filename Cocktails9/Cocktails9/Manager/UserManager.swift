//
//  UserManager.swift
//  Cocktails9
//
//  Created by Mateja Mitic on 3.12.24..
//

import Foundation

class UserManager {
    
    private static let userDefaults = UserDefaults.standard
    
    // Save user to UserDefaults
    static func saveUser(_ user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            userDefaults.set(encoded, forKey: user.email)
            AppDataManager.shared.user = user
        }
    }
    
    // Load user from UserDefaults
    static func loadUser(email: String) -> User? {
        if let savedUserData = userDefaults.data(forKey: email),
           let decodedUser = try? JSONDecoder().decode(User.self, from: savedUserData) {
            AppDataManager.shared.user = decodedUser
            return decodedUser
        }
        return nil
    }
    
    
    // Add a drink to the user's list of favorites
    static func addFavoriteDrink(to user: User, drink: Drink) -> User {
        var updatedUser = user
        updatedUser.favoriteCocktails.append(drink)
        saveUser(updatedUser)
        return updatedUser
    }
    
    // Remove a drink from the user's list of favorites
    static func removeFavoriteDrink(from user: User, drink: Drink) -> User {
        var updatedUser = user
        updatedUser.favoriteCocktails.removeAll { $0.id == drink.id }
        saveUser(updatedUser)
        return updatedUser
    }
}
