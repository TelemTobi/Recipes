//
//  RecipesError.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Flux

struct RecipesError: DecodableError {
    
    let developerMessage: String?
    
    init(_ type: Flux.Error) {
        developerMessage = type.localizedDescription
    }
}
