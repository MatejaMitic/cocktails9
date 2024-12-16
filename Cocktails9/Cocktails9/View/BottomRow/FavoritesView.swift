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
                        ForEach(user.favoriteCocktails) { drink in
                            NavigationLink(destination: CocktailDetailView(drinkId: drink.id)) {
                                GridItemView(drink: drink)
                            }
                        }
                    } else {
                        // Placeholder text if the user is not yet loaded
                        Text("Loading user data...")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }
        }
        
        .onAppear {
            Task {
                appData.user = UserManager.loadUser(email: AppDataManager.currentEmail)
            }
        }
    }
}

#Preview {
    DrinksGridView()
}
