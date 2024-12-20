import SwiftUI

struct FavoritesView: View {
    @StateObject private var appData = AppDataManager.shared
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    if let user = appData.user {
                        // Check if the user has favorite drinks
                        if user.favoriteCocktails.isEmpty {
                            Text("No favorite drinks yet.")
                                .font(.headline)
                                .foregroundColor(.gray)
                        } else {
                            // Loop through the favorite drinks
                            ForEach(user.favoriteCocktails) { drink in
                                NavigationLink(destination: CocktailDetailView(drinkId: drink.id)) {
                                    GridItemView(drink: drink)
                                }
                            }
                        }
                    } else {
                        // Placeholder text if the user data is loading or not yet available
                        Text("Loading user data...")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }
            .onAppear {
                // Use .task to load the user data asynchronously
                Task {
                    if appData.user == nil {
                        appData.user = UserManager.loadUser(email: AppDataManager.currentEmail)
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritesView()
}
