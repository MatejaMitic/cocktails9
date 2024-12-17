import SwiftUI

struct FilterView: View {
    @State private var isFilterViewDetailPresented = false
    @State private var filterType: String?

    var body: some View {
        NavigationStack {
            Form {
                // Alcoholic / Non-Alcoholic Section
                Section(header: Text("Alcoholic / Non-Alcoholic")) {
                    Button(action: {
                        filterType = "Alcoholic / Non-Alcoholic"
                        isFilterViewDetailPresented.toggle()
                    }) {
                        Text("Select Alcoholic Type")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                }

                // Glass Used Section
                Section(header: Text("Glass Used")) {
                    Button(action: {
                        filterType = "Glass Used"
                        isFilterViewDetailPresented.toggle()
                    }) {
                        Text("Select Glass Type")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                }

                // Category Section
                Section(header: Text("Category")) {
                    Button(action: {
                        filterType = "Category"
                        isFilterViewDetailPresented.toggle()
                    }) {
                        Text("Select Category")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                }

                // Ingredients Section
                Section(header: Text("Ingredients")) {
                    Button(action: {
                        filterType = "Ingredients"
                        isFilterViewDetailPresented.toggle()
                    }) {
                        Text("Select Ingredients")
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            .navigationTitle("Filters")
            .sheet(isPresented: $isFilterViewDetailPresented) {
                // Show FilterViewDetail when a category is selected
                if let filterType = filterType {
                    FilterViewDetail(filterType: filterType)
                }
            }
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
