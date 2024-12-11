import SwiftUI

struct DrinksGrid: View {
    @StateObject private var networkManager = NetworkManager.shared
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(networkManager.drinks) { drink in
                        NavigationLink {
                            // Navigation to a detail page (not implemented yet)
                        } label: {
                            GridItemView(drink: drink)
                        }
                    }
                }
                .padding()
                //.frame(height: geometry.size.height)
            }
        }
        .onAppear {
            Task {
                networkManager.user = UserManager.loadUser(email: LoginView.currentEmail)
                await networkManager.fetchDrinks()
            }
        }
    }
}

#Preview {
    DrinksGrid()
        .environmentObject(NetworkManager())
}
