import Foundation

class NetworkManager {
    
    // Private base URL and endpoints
    private static let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1"
    private static let alcoholicEndpoint = "/filter.php?a=Alcoholic"
    private static let nonAlcoholicEndpoint = "/filter.php?a=Non_Alcoholic"
    private static let searchEndpoint = "/search.php?s="
    
    // New endpoints for fetching filter options
    private static let categoryEndpoint = "/list.php?c=list"
    private static let glassEndpoint = "/list.php?g=list"
    private static let ingredientEndpoint = "/list.php?i=list"
    private static let alcoholicFilterEndpoint = "/list.php?a=list"
    
    // Fetch alcoholic drinks by default
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
    
    // Fetch drinks based on filter query
    static func fetchDrinksByFilter(query: String) async {
        guard let url = URL(string: baseUrl + "/filter.php?\(query)") else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(DrinkResponse.self, from: data)
            DispatchQueue.main.async {
                AppDataManager.shared.drinks = decodedResponse.drinks
            }
        } catch {
            print("Failed to fetch filtered drinks: \(error)")
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
    
    // Fetch list of filter options dynamically based on filter type
    static func fetchFilterOptions(filter: FilterType) async -> Result<[String], Error> {
        let endpoint: String
        switch filter {
        case .alcoholic:
            endpoint = alcoholicFilterEndpoint
        case .category:
            endpoint = categoryEndpoint
        case .glass:
            endpoint = glassEndpoint
        case .ingredients:
            endpoint = ingredientEndpoint
        }
        
        guard let url = URL(string: baseUrl + endpoint) else {
            return .failure(NetworkError.invalidURL)
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedResponse: [String: [[String: String]]] = try decoder.decode([String: [[String: String]]].self, from: data)
            
            guard let drinks = decodedResponse["drinks"] else {
                return .failure(NetworkError.decodingError)
            }
            
            let options = drinks.compactMap { $0.values.first }
            return .success(options)
        } catch {
            return .failure(error)
        }
    }
}

// Custom error handling
enum NetworkError: Error, LocalizedError {
    case invalidURL
    case networkError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL is invalid."
        case .networkError:
            return "There was a problem with the network."
        case .decodingError:
            return "Failed to decode the response."
        }
    }
}
