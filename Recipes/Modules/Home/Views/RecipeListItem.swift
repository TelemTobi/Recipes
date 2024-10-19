//
//  RecipeItemView.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import SwiftUI
import Kingfisher

struct RecipeListItem: View {
    
    let recipe: Recipe
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            KFImage(recipe.thumb)
                .fade(duration: 0.25)
                .resizable()
                .frame(width: 60, height: 60)
                .aspectRatio(contentMode: .fill)
                .clipShape(.rect(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(recipe.name ?? "Unknowm Recipe")
                    .font(.headline)
                    .lineLimit(2)
                
                Text(description)
                    .font(.footnote)
                    .lineLimit(1)
            }
        }
        .padding(.trailing)
    }
    
    var description: String {
        [calories, carbs, fats]
            .compactMap { $0 }
            .joined(separator: "  •  ")
    }
    
    var calories: String? {
        recipe.calories
    }
    
    var carbs: String? {
        guard let carbs = recipe.carbos, !carbs.isEmpty else { return nil }
        return "Carbs: \(carbs)"
    }
    
    var fats: String? {
        guard let fats = recipe.fats, !fats.isEmpty else { return nil }
        return "Fats: \(fats)"
    }
}
