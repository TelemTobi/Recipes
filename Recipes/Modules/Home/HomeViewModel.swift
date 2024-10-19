//
//  HomeViewModel.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation
import Dependencies

@MainActor
@Observable
final class HomeViewModel {
    
    private(set) var viewState: ViewState = .loading
    
    private weak var router: HomeRouter?
    private var viewStateDebouncer: Task<(), any Error>?
    
    init(router: HomeRouter) {
        self.router = router
    }
    
    func onAppear() {
        fetchRecipes()
    }
    
    func onRecipeTap(_ recipe: Recipe) {
        guard let recipeId = recipe.id else {
            viewState = .error
            return
        }
        
        Task {
            do {
                try await lockRecipe(recipe)
                router?.onRecipeTap(recipeId)
            } catch {
                // TODO: Handle that error.. 🫶
                print(error)
            }
        }
    }
    
    func onTryAgainButtonTap() {
        setViewState(.loading)
        fetchRecipes()
    }
    
    private func fetchRecipes() {
        @Dependency(\.recipesClient) var recipesClient
        
        Task {
            let result = await recipesClient.fetchRecipes()
            
            switch result {
            case let .success(recipes):
                setViewState(.loaded(recipes))
                
            case .failure:
                setViewState(.error)
            }
        }
    }
    
    private func lockRecipe(_ recipe: Recipe) async throws {
        @Dependency(\.keychainService) var keychainService
        try await keychainService.storeRecipe(recipe)
    }
    
    private func setViewState(_ state: ViewState) {
        guard state != .loading else {
            viewState = .loading
            return
        }

        // Debounces viewState changes for a better user experience
        viewStateDebouncer = Task {
            try await Task.sleep(for: .seconds(1))
            viewState = state
        }
    }
}

extension HomeViewModel {
    
    enum ViewState: Equatable {
        case loading
        case loaded([Recipe])
        case error
    }
}
