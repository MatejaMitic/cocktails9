import SwiftUI

struct DrinksGrid: View {
    @StateObject private var networkManager = NetworkManager()
    @State private var user: User?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(networkManager.drinks) { drink in
                        if let user = user{
                            NavigationLink {
                                // Navigation to a detail page (not implemented yet)
                            } label: {
                                GridItemView(drink: drink, user: user)
                            }
                        }
                    }
                }
                .padding()
                .onAppear {
                    Task {
                        user = UserManager.loadUser()
                        await networkManager.fetchDrinks()
                    }
                }
            }
        }
    }
}

#Preview {
    DrinksGrid()
        .environmentObject(NetworkManager())
}
