//
//  RecipesProvider.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation
import Dependencies
import Flux

struct RecipesProvider {
    
    private let fluxProvider: FluxProvider<RecipesEndpoint, RecipesError>
    
    init(environment: Flux.Environment = .live) {
        fluxProvider = FluxProvider(environment: environment)
    }
    
    func fetchRecipes() async -> Result<[Recipe], RecipesError> {
        await fluxProvider.request(.recipes)
    }
}

extension RecipesProvider: DependencyKey {
    static let liveValue = RecipesProvider(environment: .live)
    static let testValue = RecipesProvider(environment: .test)
    static let previewValue = RecipesProvider(environment: .preview)
}

extension DependencyValues {
    var recipesProvider: RecipesProvider {
        get { self[RecipesProvider.self] }
        set { self[RecipesProvider.self] = newValue }
    }
}
