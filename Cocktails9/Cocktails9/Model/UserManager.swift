//
//  UserManager.swift
//  Cocktails9
//
//  Created by Mateja Mitic on 4.12.24..
//

import Foundation

class UserManager {
    
    private static let userDefaults = UserDefaults.standard
    //private static let userKey = "currentUser"
    
    // Save user to UserDefaults
    static func saveUser(_ user: User) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            userDefaults.set(encoded, forKey: user.email)
        }
    }
    
    // Load user from UserDefaults
    static func loadUser(email: String) -> User? {
        if let savedUserData = userDefaults.data(forKey: email),
           let decodedUser = try? JSONDecoder().decode(User.self, from: savedUserData) {
            return decodedUser
        }
        return nil
    }
    
    
    
    
}
