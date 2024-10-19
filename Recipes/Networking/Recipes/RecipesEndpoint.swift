//
//  RecipesEndpoints.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation
import Flux

enum RecipesEndpoint {
    case recipes
}

extension RecipesEndpoint: Endpoint {
    
    var baseURL: URL {
        URL(string: "https://hf-android-app.s3-eu-west-1.amazonaws.com")!
    }
    
    var path: String {
        switch self {
        case .recipes: "/android-test/recipes.json"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .recipes: .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .recipes: .empty
        }
    }
    
    var shouldPrintLogs: Bool {
        true
    }
}
