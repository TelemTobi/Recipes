//
//  AppNavigator.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation
import SwiftUI

@Observable
final class AppNavigator: HomeRouter, RecipeRouter {
    
    public enum Destination: Hashable {
        case details(_ recipeId: String)
    }
    
    var path: [Destination] = []
    
    func onRecipeTap(_ recipeId: String) {
        path.append(.details(recipeId))
    }
}

extension AppNavigator {
    
    struct ContentView: View {
        
        @Bindable private var navigator = AppNavigator()
        
        var body: some View {
            NavigationStack(path: $navigator.path) {
                HomeView(viewModel: HomeViewModel(router: navigator))
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case let .details(recipeId):
                            let viewModel = RecipeViewModel(router: navigator, recipeId: recipeId)
                            RecipeView(viewModel: viewModel)
                        }
                    }
            }
        }
    }
}
