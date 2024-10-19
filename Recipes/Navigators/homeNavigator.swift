//
//  HomeNavigator.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation
import SwiftUI

@MainActor
@Observable
final class HomeNavigator: HomeRouter, RecipeRouter {
    
    public enum Destination: Hashable {
        case recipe(_ recipeId: String)
    }
    
    var path: [Destination]

    @ObservationIgnored
    private(set) lazy var root = HomeViewModel(router: self)

    init(path: [Destination] = []) {
        self.path = path
    }
    
    func onRecipeTap(_ recipeId: String) {
        path.append(.recipe(recipeId))
    }
}

extension HomeNavigator {
    
    struct ContentView: View {
        
        @Bindable var navigator: HomeNavigator
        
        var body: some View {
            NavigationStack(path: $navigator.path) {
                HomeView(viewModel: navigator.root)
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case let .recipe(recipeId):
                            let viewModel = RecipeViewModel(router: navigator, recipeId: recipeId)
                            RecipeView(viewModel: viewModel)
                        }
                    }
            }
        }
    }
}
