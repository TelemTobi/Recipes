//
//  HomeRouter.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

@MainActor
protocol HomeRouter: AnyObject {
    func onRecipeTap(_ recipeId: String)
}
