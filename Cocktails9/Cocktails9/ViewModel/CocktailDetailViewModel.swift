import Foundation

class CocktailDetailViewModel: ObservableObject {
    @Published var drinkDetail: DrinkDetails? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    func fetchCocktailDetails(id: String) {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                // Call NetworkManager to fetch the cocktail details
                let fetchedCocktail = try await NetworkManager.fetchCocktailDetails(id: id)
                
                // Update the state with the fetched cocktail
                if let fetchedCocktail = fetchedCocktail {
                    self.drinkDetail = fetchedCocktail
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


