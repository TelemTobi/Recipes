//
//  KeychainService.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation
import Dependencies
import KeychainAccess

struct KeychainService {
    var storeRecipe: (Recipe) async throws -> Void
    var retrieveRecipe: (String) async throws -> Recipe
    
    private static let keychain = Keychain(
        server: Bundle.main.bundleIdentifier ?? #file,
        protocolType: .https
    )
}

extension KeychainService: DependencyKey {
    static let liveValue = KeychainService(
        storeRecipe: { recipe in
            guard let data = try? JSONEncoder().encode(recipe) else {
                throw(Status.invalidEncoding)
            }
            
            try keychain
                .accessibility(.whenUnlocked, authenticationPolicy: [.userPresence])
                .set(data, key: recipe.id ?? "recipe")
        },
        retrieveRecipe: { recipeId in
            let data = try keychain
                .authenticationPrompt("Authenticate to unlock recipe")
                .getData(recipeId)
            
            guard let data else {
                throw(Status.itemNotFound)
            }
            
            guard let recipe = try? JSONDecoder().decode(Recipe.self, from: data) else {
                throw(Status.decode)
            }
            
            return recipe
        }
    )
}

extension DependencyValues {
    var keychainService: KeychainService {
        get { self[KeychainService.self] }
        set { self[KeychainService.self] = newValue }
    }
}
