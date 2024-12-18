import SwiftUI

struct FilterView: View {
    @Binding var isPresented: Bool
    @Binding var selectedAlcoholic: String
    @Binding var selectedGlass: String
    @Binding var selectedCategory: String
    @Binding var selectedIngredients: [String]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Alcoholic")) {
                    Text("Alcoholic Section")
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("Glass Type")) {
                    Text("Glass Type Section")
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("Category")) {
                    Text("Category Section")
                        .foregroundColor(.gray)
                }
                
                Section(header: Text("Ingredients")) {
                    Text("Ingredients Section")
                        .foregroundColor(.gray)
                }
            }
            .navigationBarTitle("Filters", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                isPresented = false
            })
        }
    }
    
}

#Preview {
    FilterView(isPresented: .constant(true), selectedAlcoholic: .constant("All"), selectedGlass: .constant("All"), selectedCategory: .constant("All"), selectedIngredients: .constant([]))
}
