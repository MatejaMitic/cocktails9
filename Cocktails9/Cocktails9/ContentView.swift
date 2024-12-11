import SwiftUI

struct ContentView: View {
    @StateObject var networkManager = NetworkManager()
    //@AppStorage("currentUser") private var currentUserData: Data?
    
    
    
    var body: some View {
        LoginView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.sizeThatFits)
    }
}

