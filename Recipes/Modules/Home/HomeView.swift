//
//  HomeView.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    let viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}
