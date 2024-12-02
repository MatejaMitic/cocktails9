import SwiftUI

struct BottomRowView: View {
    @State private var selection: String? = nil  // Used for navigation
    
    var body: some View {
        HStack {
            // Cocktails Button
            NavigationLink(destination: Text("Cocktails View")) {
                VStack {
                    Image(systemName: "wineglass.fill")
                        .font(.title)
                        Text("Cocktails")
                        .font(.headline)
                        .foregroundColor(.black.opacity(0.8))
                }
                .padding()
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .buttonStyle(PlainButtonStyle()) // To prevent the entire button area from becoming tappable, only the icon is tappable
            
            // Favorites Button
            NavigationLink(destination: Text("Favorites View")) {
                VStack {
                    Image(systemName: "star.fill")
                        .font(.title)
                    Text("Favorites")
                        .font(.headline)
                        .foregroundColor(.black.opacity(0.8))
                }
                .padding()
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .buttonStyle(PlainButtonStyle())
            
            // Profile Button
            NavigationLink(destination: Text("Profile View")) {
                VStack {
                    Image(systemName: "person.fill") 
                        .font(.title)
                    Text("Profile")
                        .font(.headline)
                        .foregroundColor(.black.opacity(0.8))
                }
                .padding()
                .cornerRadius(10)
                .shadow(radius: 5)
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .frame(maxWidth: .infinity)
        .padding()  
        .background(Color.green.opacity(0.0))
    }
}

#Preview {
    NavigationStack {
        BottomRowView()
    }
}
