import SwiftUI

struct CocktailDetailView: View {
    @StateObject private var viewModel = CocktailDetailViewModel()
    let drinkId: String
    
    var body: some View {
        ScrollView {
            // Cocktail Thumbnail Image
            AsyncImage(url: URL(string: viewModel.cocktail?.strDrinkThumb ?? "")) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 10)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(height: 300)
            }
            .padding(.top)
            
            VStack(alignment: .leading, spacing: 20) {
                // Cocktail Name and Alcoholic Category
                if let cocktail = viewModel.cocktail {
                    HStack {
                        Text(cocktail.strDrink)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text(cocktail.strAlcoholic ?? "Unknown")
                            .font(.subheadline)
                            .foregroundColor(cocktail.strAlcoholic == "Alcoholic" ? .green : .orange)
                    }
                    
                    // Glass and Category Information
                    HStack {
                        if let glass = cocktail.strGlass {
                            Text("Glass: \(glass)")
                                .font(.subheadline)
                        }
                        Spacer()
                        if let category = cocktail.strCategory {
                            Text("Category: \(category)")
                                .font(.subheadline)
                        }
                    }
                    .foregroundColor(.secondary)
                    
                    Divider()
                    
                    // Ingredients Section
                    Text("Ingredients")
                        .font(.title2)
                        .padding(.top)
                    
                    ForEach(cocktail.ingredientsAndMeasures, id: \.ingredient) { ingredient, measure in
                        HStack {
                            Text(ingredient)
                            Spacer()
                            Text(measure)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Divider()
                    
                    // Instructions
                    Text("Instructions")
                        .font(.title2)
                        .padding(.top)
                    Text(cocktail.strInstructions)
                        .font(.body)
                        .padding(.bottom)
                }
            }
            .padding()
        }
        .background(.green.opacity(0.2))
        .navigationTitle(viewModel.cocktail?.strDrink ?? "Cocktail Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchCocktailDetails(id: drinkId)
        }
    }
}

struct CocktailDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CocktailDetailView(drinkId: "11007")
            .environmentObject(CocktailDetailViewModel())
    }
}
