import SwiftUI

struct DrinksGridView: View {
    @StateObject private var appData = AppDataManager.shared
    @State private var searchQuery: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @State private var isSearchBarActive: Bool = false
    
    // For showing the FilterView sheet
    @State private var isFilterViewPresented = false

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
                    
                    // Filter Button to show the FilterView as a sheet
                    Button(action: {
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
            Task {
                await NetworkManager.fetchDrinks() // Load initial drinks
            }
        }
        .sheet(isPresented: $isFilterViewPresented) {
            // Show FilterView
            FilterView()
        }
    }
}
