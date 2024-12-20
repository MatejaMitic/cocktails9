import SwiftUI

struct CocktailDetailView: View {
    @StateObject private var viewModel = CocktailDetailViewModel()
    let drinkId: String
    
    var body: some View {
        ScrollView {
            // Cocktail Thumbnail Image
            AsyncImage(url: URL(string: viewModel.drinkDetail?.drinkThumb ?? "")) { image in
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
                if let cocktail = viewModel.drinkDetail {
                    HStack {
                        Text(cocktail.drink)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text(cocktail.alcoholic ?? "Unknown")
                            .font(.subheadline)
                            .foregroundColor(cocktail.alcoholic == "Alcoholic" ? .green : .orange)
                    }
                    
                    // Glass and Category Information
                    HStack {
                        if let glass = cocktail.glass {
                            Text("Glass: \(glass)")
                                .font(.subheadline)
                        }
                        Spacer()
                        if let category = cocktail.category {
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
                    Text(cocktail.instructions)
                        .font(.body)
                        .padding(.bottom)
                }
            }
            .padding()
        }
        .background(.green.opacity(0.2))
        .navigationTitle(viewModel.drinkDetail?.drink ?? "Cocktail Details")
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
