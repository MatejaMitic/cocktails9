//
//  AppDataManager.swift
//  Cocktails9
//
//  Created by Mateja Mitic on 12.12.24..
//

import Foundation

import SwiftUI

class AppDataManager: ObservableObject {

    static let shared = AppDataManager()

    @Published var drinks: [Drink] = []
    @Published var user: User?
    @State var isLoggedIn: Bool = false
    static var currentEmail: String = ""
}
