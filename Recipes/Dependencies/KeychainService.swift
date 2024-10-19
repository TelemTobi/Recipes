//
//  KeychainService.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation
import Dependencies
import Security

struct KeychainService {
    var storeRecipe: (Recipe) throws -> Void
    var retrieveRecipe: (String) throws -> Recipe
}

extension KeychainService: DependencyKey {
    static let liveValue = KeychainService(
        storeRecipe: { recipe in
            guard let data = try? JSONEncoder().encode(recipe) else {
                throw(KeychainError.encodingError)
            }
            
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: Key.recipe.rawValue,
                kSecValueData as String: data
            ]
            
            let status = SecItemAdd(query as CFDictionary, nil)
            
            if status != errSecSuccess {
                throw KeychainError.unhandledError(status: status)
            }
        },
        retrieveRecipe: { recipeId in
            
        }
    )
}

extension KeychainService {
    fileprivate enum Key: String {
        case recipe
    }
}

enum KeychainError: Error {
    case noPassword
    case encodingError
    case unhandledError(status: OSStatus)
}
