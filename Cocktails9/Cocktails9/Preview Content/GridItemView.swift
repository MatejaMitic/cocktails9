import SwiftUI

struct GridItemView: View {
    @State var drink: Drink
    @State var user: User
    
    var body: some View {
        let isFavourite = user.favoriteCocktails.contains(where: { $0.id == drink.id })
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: drink.imageUrl)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 155, height: 155)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
            // HStack to hold both the drink name and favorite button
            HStack {
                Text(drink.name)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .padding(.top, 5)
                    .frame(maxWidth: 150) // Adjust max width if necessary
                    .foregroundColor(.black)

                Spacer()  // Push the favorite button to the right side
                
                Button(action: {
                    if isFavourite {
                        user = UserManager.removeFavoriteDrink(from: user, drink: drink)
                    } else {
                        user = UserManager.addFavoriteDrink(to: user, drink: drink)
                    }
                }) {
                    Image(systemName: isFavourite ? "heart.fill" : "heart")
                        .foregroundColor(isFavourite ? .red : .gray)
                        //.padding(5)  
                }
            }
            .padding(.top, 5)  // Padding between the name and the heart button
        }
        .padding(.bottom, 10)  // Padding at the bottom of the whole item
    }
}