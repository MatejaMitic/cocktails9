import Foundation

class NetworkManager {
    
    // Fetch alcoholic drinks (the default method)
    static func fetchDrinks() async {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(DrinkResponse.self, from: data)
            DispatchQueue.main.async {
                AppDataManager.shared.drinks = decodedResponse.drinks
            }
        } catch {
            print("Failed to fetch drinks: \(error)")
        }
    }
    
    // Search cocktails based on query
    static func searchCocktails(query: String) async {
        guard !query.isEmpty,
              let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
                  return
              }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(DrinkResponse.self, from: data)
            DispatchQueue.main.async {
                AppDataManager.shared.drinks = decodedResponse.drinks ?? [] // In case of no results, set empty list
            }
        } catch {
            print("Failed to search cocktails: \(error)")
        }
    }
}
