import SwiftUI

struct FilterViewDetail: View {
    let filterType: String
    @State private var options: [String] = []  // List of filter options (dynamic)
    @State private var selectedOption: String? = nil
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Text("Select \(filterType)")
                .font(.title)
                .padding()

            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            } else {
                List(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }) {
                        HStack {
                            Text(option)
                            if option == selectedOption {
                                Spacer()
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                    }
                }
            }
            
            Spacer()
        }
        .navigationTitle(filterType)
        .onAppear {
            loadOptions()
        }
    }

    private func loadOptions() {
        isLoading = true
        errorMessage = nil
        
        // Fetching options based on filter type
        Task {
            let filterTypeEnum: FilterType
            switch filterType {
            case "Alcoholic / Non-Alcoholic":
                filterTypeEnum = .alcoholic
            case "Glass Used":
                filterTypeEnum = .glass
            case "Category":
                filterTypeEnum = .category
            case "Ingredients":
                filterTypeEnum = .ingredient
            default:
                filterTypeEnum = .alcoholic
            }
            
            let result = await NetworkManager.fetchFilterOptions(filter: filterTypeEnum)
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedOptions):
                    self.options = fetchedOptions
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
                isLoading = false
            }
        }
    }
}

struct FilterViewDetail_Previews: PreviewProvider {
    static var previews: some View {
        FilterViewDetail(filterType: "Alcoholic / Non-Alcoholic")
    }
}
