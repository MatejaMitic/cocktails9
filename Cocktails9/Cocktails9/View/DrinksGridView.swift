import SwiftUI

struct DrinksGridView: View {
    @StateObject private var appData = AppDataManager.shared
    @State private var searchQuery: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @State private var isSearchBarActive: Bool = false
    
    @State private var isFilterViewPresented: Bool = false  // State to trigger filter view presentation
    
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
                    
                    // Filter Button
                    Button(action: {
                        // Toggle the state to show the FilterView sheet
                        isFilterViewPresented.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title)
                            .foregroundColor(.primary)
                            .padding()
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                
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
            .onAppear {
                // Load initial drinks when view appears
                Task {
                    AppDataManager.shared.user = UserManager.loadUser(email: AppDataManager.currentEmail)
                    await NetworkManager.fetchDrinks() // Load the default alcoholic drinks when the view appears
                }
            }
            // Show the filter view as a modal sheet
            .sheet(isPresented: $isFilterViewPresented) {
                //FilterView(isFiltering: $isFiltering) // Pass the binding to `FilterView`
            }
        }
    }
}
