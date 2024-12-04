//
//  ContentView.swift
//  Cocktails9
//
//  Created by Mateja Mitic on 26.11.24..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                TopRowView()
                
                BottomRowView()
            }
            .background(Color.green.opacity(0.2))
        }
    }
}

#Preview {
    ContentView()
}