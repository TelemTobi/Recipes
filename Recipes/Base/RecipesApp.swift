//
//  RecipesApp.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import SwiftUI

@main
struct RecipesApp: App {
    
    private let appController = AppController()
    
    var body: some Scene {
        WindowGroup {
            switch appController.state {
            case let .loggedIn(homeNavigator):
                HomeNavigator.ContentView(
                    navigator: homeNavigator
                )
            }
        }
    }
}
