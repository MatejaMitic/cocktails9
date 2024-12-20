import SwiftUI

struct FilterViewDetail: View {
    let filterType: String
    @State private var options: [String] = []  // List of filter options (dynamic)
    @State private var selectedOption: String? = nil
    @State private var isLoading = false
    @State private var errorMessage: String?

    // Closure to pass the selected filter option back to the parent view
    var applyFilter: (String?) -> Void
    
    var body: some View {
        VStack {
            Text("Select \(filterType)")
                .font(.title)
                .padding()
                .foregroundColor(.primary) // Ensures the text is easy to read

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
                        applyFilter(option) // Call the closure to pass the selected option back
                    }) {
                        HStack {
                            Text(option)
                                .foregroundColor(.primary) // Text color

                            Spacer()

                            // Checkmark icon for selected option
                            if option == selectedOption {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .background(Color.green.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))  // Green background with opacity for each list item
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            Spacer()
        }
        .navigationTitle(filterType)
        .onAppear {
            loadOptions()
        }
        .background(Color.green.opacity(0.2).edgesIgnoringSafeArea(.all)) // Green background with opacity for the whole view
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
                filterTypeEnum = .ingredients
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
        FilterViewDetail(filterType: "Alcoholic / Non-Alcoholic") { selectedOption in
            print("Selected: \(selectedOption ?? "None")")
        }
    }
}
