import SwiftUI

struct ContentView: View {
    @StateObject var networkManager = NetworkManager()
    //@AppStorage("currentUser") private var currentUserData: Data?
    
    
    
    var body: some View {
        VStack {
            // Show first drink when the data is available
            if let firstDrink = networkManager.drinks.first, let user = UserManager.loadUser() {
                GridItemView(drink: firstDrink, user: user)
            } else {
                // Show loading text if drinks data is still being fetched
                Text("Loading...")
                    .onAppear {
                        // Fetch drinks when the view first appears
                        Task {
                            // Fetch data only if it hasn't been fetched already
                            if networkManager.drinks.isEmpty {
                                await networkManager.fetchDrinks()
                            }
                        }
                    }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
