//
//  Recipe.swift
//  Recipes
//
//  Created by Telem Tobi on 19/10/2024.
//

import Foundation

struct Recipe: Codable, Equatable, Identifiable, Hashable {
    
    let id: String?
    let name: String?
    let description: String?
    let headline: String?
    let calories: String?
    let carbos: String?
    let fats: String?
    let proteins: String?
    let time: String?
    let difficulty: DifficultyLevel?
    let image: URL?
    let thumb: URL?
    let country: String?
    
    enum DifficultyLevel: Int, Decodable {
        case easy = 0
        case medium = 1
        case hard = 2
        case veryHard = 3
        case unknown
        
        // Makes sure decoding won't fail if we recieve an unknown case 👇
        init(from decoder: any Decoder) throws {
            let container = try decoder.singleValueContainer()
            let rawValue = try container.decode(Int.self)
            self = DifficultyLevel(rawValue: rawValue) ?? .unknown
        }
    }
}
