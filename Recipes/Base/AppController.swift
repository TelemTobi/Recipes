//
//  AppController.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation

@MainActor
@Observable
final class AppController {
    
    private(set) var state: State
    
    init() {
        // We currently don't have a login option so we're always logged in 👇
        let homeNavigator = HomeNavigator()
        self.state = .loggedIn(homeNavigator)
    }
    
    enum State {
        case loggedIn(HomeNavigator)
    }
}
