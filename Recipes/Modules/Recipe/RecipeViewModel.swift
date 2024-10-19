//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation
import Dependencies

@MainActor
@Observable
final class RecipeViewModel {
    
    private(set) var viewState: ViewState = .locked
    
    private weak var router: HomeRouter?
    private let recipeId: String
    
    init(router: HomeRouter, recipeId: String) {
        self.router = router
        self.recipeId = recipeId
    }
    
    func onUnlockButtonTap() {
        
    }
}

extension RecipeViewModel {
    
    enum ViewState: Equatable {
        case locked
        case unlocked(Recipe)
    }
}
