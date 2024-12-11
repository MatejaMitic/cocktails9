//
//  topRow.swift
//  Cocktails9
//
//  Created by Mateja Mitic on 2.12.24..
//

import SwiftUI

struct TopRowView: View {
    @State private var searchQuery: String = ""  // For holding search text
    @State private var isFiltering: Bool = false  // For handling filter state
    
    var body: some View {
        NavigationStack {
            HStack {
                Text("Cocktails9")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.leading, 10)
                
                Spacer()
                
                // Search Button
                Button(action: {
                    // Perform search action (e.g., navigate to search screen or show search bar)
                }) {
                    Image(systemName: "magnifyingglass") // Search icon from SF Symbols
                        .font(.title)
                        .foregroundColor(.primary)
                        .padding()
                }
                .padding(.trailing, 10) // Padding to the right
                
                // Filter Button
                Button(action: {
                    isFiltering.toggle()
                    print("Filter tapped, is filtering: \(isFiltering)")
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                        .font(.title)
                        .foregroundColor(.primary)
                    
                }
                
            }
            .background(Color.clear)
            .padding(.top)
            .padding(.horizontal)
            .padding(.trailing)
        }
        
        Spacer()
    }
    
}

#Preview {
    TopRowView()
}
