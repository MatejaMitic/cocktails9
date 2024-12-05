import SwiftUI

struct LandmarkGrid: View {
    @StateObject private var networkManager = NetworkManager()
    @AppStorage("currentUser") private var currentUserData: Data?
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private func loadUser() -> User? {
            guard let currentUserData = currentUserData else { return nil }
            let decoder = JSONDecoder()
            return try? decoder.decode(User.self, from: currentUserData) // Decode Data into User
        }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(networkManager.drinks) { drink in
                        if let user = loadUser(){
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
                        await networkManager.fetchDrinks()
                    }
                }
            }
         }
    }
}

#Preview {
    LandmarkGrid()
        .environmentObject(NetworkManager()) 
}
