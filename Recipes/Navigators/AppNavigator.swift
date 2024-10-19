//
//  AppNavigator.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation
import SwiftUI

final class AppNavigator: ObservableObject, HomeRouter {
    
    public enum Destination: Hashable {
        case details(Recipe)
    }
    
    @Published var path: [Destination] = []
    
    func onRecipeTap(_ recipe: Recipe) {
        path.append(.details(recipe))
    }
}

extension AppNavigator {
    
    struct ContentView: View {
        
        @ObservedObject private var navigator = AppNavigator()
        
        var body: some View {
            NavigationStack(path: $navigator.path) {
                HomeView(viewModel: HomeViewModel(router: navigator))
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case let .details(recipe):
                            Text(recipe.name ?? "Unknown") // TODO: Create DetailsView
                        }
                    }
            }
        }
    }
}
