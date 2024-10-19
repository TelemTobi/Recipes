//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation

@MainActor
@Observable
final class HomeViewModel {
    
//    @Published var recipes: [Recipe]?
    
    private weak var router: HomeRouter?
    
    init(router: HomeRouter) {
        self.router = router
    }
    
    func onAppear() {
        fetchRecipes()
    }
    
    func onRecipeTap(_ recipe: Recipe) {
        router?.onRecipeTap(recipe)
    }
    
    private func fetchRecipes() {
        Task {
            
        }
    }
}
