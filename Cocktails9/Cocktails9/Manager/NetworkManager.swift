import Foundation

class NetworkManager {
    // Private base URL and endpoints
    private static let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1"
    private static let alcoholicEndpoint = "/filter.php?a=Alcoholic"
    private static let searchEndpoint = "/search.php?s="
    
    // Fetch alcoholic drinks
    static func fetchDrinks() async {
        guard let url = URL(string: baseUrl + alcoholicEndpoint) else { return }
        
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
              let url = URL(string: baseUrl + searchEndpoint + (query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")) else {
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
    
    static func fetchFilteredDrinks(endpoint: String) async {
        guard let url = URL(string: baseUrl + endpoint) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(DrinkResponse.self, from: data)
            DispatchQueue.main.async {
                AppDataManager.shared.drinks = decodedResponse.drinks ?? [] // Update the shared data
            }
        } catch {
            print("Failed to fetch filtered drinks: \(error)")
        }
    }
    
    static func fetchList(endpoint: String) async throws -> [String] {
        guard let url = URL(string: baseUrl + "/" + endpoint) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            
            // Since each list (categories, glasses, etc.) is wrapped in a dictionary, decode it accordingly
            let response = try decoder.decode(FilterResponse.self, from: data)
            
            // Return the list of strings (e.g., categories, glasses, etc.)
            return response.drinks?.map { $0.name } ?? []
        } catch {
            print("Failed to fetch list: \(error)")
            throw error
        }
    }
    
    static func fetchCocktailDetails(id: String) async throws -> DrinkDetails? {
            let urlString = baseUrl + "/lookup.php?i=\(id)"
            
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(DrinkDetailsResponse.self, from: data)
                return decodedResponse.drinks?.first // Return the first cocktail if available
            } catch {
                throw error // Re-throw the error to be handled by the caller
            }
        }
    
}
