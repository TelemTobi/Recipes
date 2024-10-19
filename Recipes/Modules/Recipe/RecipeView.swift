//
//  RecipeView.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import SwiftUI

struct RecipeView: View {
    
    let viewModel: RecipeViewModel
    
    var body: some View {
        ZStack {
            switch viewModel.viewState {
            case .locked:
                lockedContentView()
                
            case let .unlocked(recipe):
                unlockedContentView(recipe)
            }
        }
        .animation(.smooth, value: viewModel.viewState)
    }
    
    @ViewBuilder
    private func lockedContentView() -> some View {
        VStack {
            Text("Recipe is locked")
                .font(.title)
                .fontWeight(.medium)
            
            Button {
                viewModel.onUnlockButtonTap()
            } label: {
                Text("Unlock")
                    .font(.body)
                    .padding(.horizontal)
            }
            .padding(.horizontal)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
        }
    }
    
    @ViewBuilder
    private func unlockedContentView(_ recipe: Recipe) -> some View {
        VStack {
            
        }
    }
}
