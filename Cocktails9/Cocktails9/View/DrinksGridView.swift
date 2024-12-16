import SwiftUI

struct DrinksGridView: View {
    @StateObject private var appData = AppDataManager.shared // Shared AppDataManager
    @State private var searchQuery: String = ""  // For holding search text
    @State private var isFiltering: Bool = false  // For handling filter state
    @State private var isLoading: Bool = false    // To show loading indicator
    @State private var errorMessage: String? = nil // For handling API errors
    @State private var isSearchBarActive: Bool = false // To control visibility of the search bar
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Function to perform search when magnifying glass is clicked
    private func searchCocktails() {
        guard !searchQuery.isEmpty else { return }
        
        isLoading = true  // Start loading
        errorMessage = nil // Clear previous error message
        
        // Perform the search API call asynchronously
        Task {
            await NetworkManager.searchCocktails(query: searchQuery) // Fetch drinks based on query
            isLoading = false  // Stop loading
            if appData.drinks.isEmpty {
                errorMessage = "No cocktails found." // If no results are found, show a message
            }
        }
    }

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
                            // If the search bar is already active, hide it and perform the search
                            isSearchBarActive = false
                            searchCocktails()
                        } else {
                            // If the search bar is not active, show it
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
                    
                    // Filter Button
                    Button(action: {
                        isFiltering.toggle()
                        print("Filter tapped, is filtering: \(isFiltering)")
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                    
                }
                .background(Color.clear)
                .padding(.top)
                .padding(.horizontal)
                .padding(.trailing)
                
                if isSearchBarActive {
                    HStack {
                        TextField("Search Cocktails", text: $searchQuery)
                            .padding(8)
                            .background(Color.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
                            .onSubmit {
                                searchCocktails()
                            }
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        Button(action: {
                            isSearchBarActive = false  // Dismiss the search bar and keyboard
                            searchCocktails()
                        }) {
                            Text("Search")
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.horizontal)
                    .transition(.move(edge: .top))  // Smooth transition for the search bar
                }

                // Show loading indicator while fetching data
                if isLoading {
                    ProgressView("Searching...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                }
                
                // Show error message if needed (e.g., no cocktails found)
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                // Display results in a grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(appData.drinks) { drink in
                            NavigationLink {
                                // Navigation to a detail page (not implemented yet)
                            } label: {
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
            // Load initial drinks when view appears
            Task {
                AppDataManager.shared.user = UserManager.loadUser(email: AppDataManager.currentEmail)
                await NetworkManager.fetchDrinks() // Load the default alcoholic drinks when the view appears
            }
        }
    }
}

#Preview {
    DrinksGridView()
}
