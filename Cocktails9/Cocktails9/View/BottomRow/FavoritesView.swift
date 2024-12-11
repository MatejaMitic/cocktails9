import SwiftUI

struct FavoritesView: View {
    @StateObject private var networkManager = NetworkManager.shared
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    if let user = networkManager.user {
                        ForEach(user.favoriteCocktails) { drink in
                            NavigationLink {
                                // Navigation to a detail page (not implemented yet)
                            } label: {
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
                networkManager.user = UserManager.loadUser(email: LoginView.currentEmail)
            }
        }
    }
}

#Preview {
    DrinksGrid()
        .environmentObject(NetworkManager())
}
