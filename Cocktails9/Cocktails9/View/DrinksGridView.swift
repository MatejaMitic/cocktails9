import SwiftUI

struct DrinksGridView: View {
    @StateObject private var appData = AppDataManager.shared
    @State private var searchQuery: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @State private var isSearchBarActive: Bool = false
    
    // Filter state
    @State private var selectedAlcoholic: String? = "Alcoholic"  // Default to "Alcoholic"
    @State private var selectedGlass: String? = nil
    @State private var selectedCategory: String? = nil
    @State private var selectedIngredients: String? = nil
    
    // Columns for the grid
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                // Top Row - Search and Filter buttons
                HStack {
                    Text("Cocktails9")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    // Search Button
                    Button(action: {
                        if isSearchBarActive {
                            isSearchBarActive = false
                            // Perform search action here
                        } else {
                            withAnimation {
                                isSearchBarActive.toggle()
                            }
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding()
                    }
                    .padding(.trailing, 10)
                    
                    // Filter NavigationLink
                    NavigationLink(destination: FilterView(applyFilters: applyFilters)) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding()
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                
                // Show loading indicator while fetching data
                if isLoading {
                    ProgressView("Searching...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                
                // Show error message if needed
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Display results in a grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(appData.drinks) { drink in
                            NavigationLink(destination: CocktailDetailView(drinkId: drink.id)) {
                                GridItemView(drink: drink)
                            }
                        }
                    }
                    .padding()
                }
                
                // If there are no results, show a message below the grid
                if appData.drinks.isEmpty && !isLoading && errorMessage == nil {
                    Text("No cocktails found.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
        .onAppear {
            // Default fetch when app loads for the first time (Alcoholic drinks)
            Task {
                await fetchDrinks()  // Load alcoholic drinks by default
            }
        }
        .onChange(of: selectedAlcoholic) { _, _ in
            // Trigger filter refresh whenever any filter changes
            Task {
                await fetchDrinks()
            }
        }
        .onChange(of: selectedGlass) { _, _ in
            Task {
                await fetchDrinks()
            }
        }
        .onChange(of: selectedCategory) { _, _ in
            Task {
                await fetchDrinks()
            }
        }
        .onChange(of: selectedIngredients) { _, _ in
            Task {
                await fetchDrinks()
            }
        }
    }
    
    // Apply filters when selected
    func applyFilters(alcoholic: String?, glass: String?, category: String?, ingredients: String?) {
        // Update the state with the selected filters
        self.selectedAlcoholic = alcoholic
        self.selectedGlass = glass
        self.selectedCategory = category
        self.selectedIngredients = ingredients
        
        // Trigger a fetch after applying filters
        Task {
            await fetchDrinks()
        }
    }
    
    // Function to fetch drinks with the applied filters
    func fetchDrinks() async {
        isLoading = true
        errorMessage = nil
        
        var urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?"
        
        // Append filter query parameters
        if let alcoholic = selectedAlcoholic {
            urlString += "a=\(alcoholic)"
        }
        if let category = selectedCategory {
            urlString += "&c=\(category)"
        }
        if let glass = selectedGlass {
            urlString += "&g=\(glass)"
        }
        if let ingredients = selectedIngredients {
            urlString += "&i=\(ingredients)"
        }
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid filter URL"
            self.isLoading = false
            return
        }
        
        // Fetch data from the network
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode(DrinkResponse.self, from: data)
            
            DispatchQueue.main.async {
                appData.drinks = decodedResponse.drinks
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
}
