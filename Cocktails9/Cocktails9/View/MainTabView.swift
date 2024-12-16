//
//  ContentView.swift
//  Cocktails9
//
//  Created by Mateja Mitic on 26.11.24..
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        NavigationStack {
            BottomRowView()
                .background(Color.green.opacity(0.2))
            
        }
    }
}

#Preview {
    MainTabView()
}
