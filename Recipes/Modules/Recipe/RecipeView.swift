//
//  RecipeView.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import SwiftUI
import Kingfisher

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
        .padding(.horizontal)
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
        ScrollView {
            KFImage(recipe.image)
                .fade(duration: 0.25)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100)
                .clipShape(.rect(cornerRadius: 8))
            
            Text(recipe.name ?? "")
                .font(.title)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            VStack(spacing: 16) {
                Text(recipe.description ?? "")
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.leading)
                
                ForEach(macros(for: recipe), id: \.0) { key, value in
                    Divider()
                    
                    HStack {
                        Text(key)
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Spacer()
                        
                        Text(value)
                            .font(.body)
                            .fontWeight(.medium)
                    }
                }
            }
            .padding(.vertical, 16)
        }
    }
    
    private func macros(for recipe: Recipe) -> [(String, String)] {
        [
            ("Calories: ", recipe.calories),
            ("Carbs: ", recipe.carbos),
            ("Fats: ", recipe.fats),
            ("Proteins: ", recipe.proteins)
        ].compactMap { (key, value) in
            guard let value else { return nil }
            return (key, value)
        }
    }
}
