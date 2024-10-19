//
//  RecipesClient.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation
import Dependencies

struct RecipesClient: DependencyKey {
    
    var fetchRecipes: @Sendable () async -> Result<[Recipe], RecipesError>
    
    static let liveValue = RecipesClient(
        fetchRecipes: {
            @Dependency(\.recipesProvider) var provider
            return await provider.fetchRecipes()
        }
    )
}

extension DependencyValues {
    var recipesClient: RecipesClient {
        get { self[RecipesClient.self] }
        set { self[RecipesClient.self] = newValue }
    }
}
