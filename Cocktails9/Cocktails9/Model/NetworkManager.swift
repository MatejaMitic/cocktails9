import Foundation

import SwiftUI

class NetworkManager: ObservableObject {
    @Published var drinks: [Drink] = []
    
    // Fetch drinks from the API
    func fetchDrinks() async {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(DrinkResponse.self, from: data)
            DispatchQueue.main.async {
                self.drinks = decodedResponse.drinks
            }
        } catch {
            print("Failed to fetch drinks: \(error)")
        }
    }
}
