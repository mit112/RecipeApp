//
//  Recipe.swift
//  RecipeApp
//
//  Created by Mit Sheth on 11/8/24.
//


import Foundation

struct RecipeResponse: Codable {
    let recipes: [Recipe]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // Filter out any recipes that fail to decode
        recipes = (try container.decode([Recipe?].self, forKey: .recipes))
            .compactMap { $0 }
    }
}

struct Recipe: Codable, Identifiable {
    let cuisine: String
    let name: String
    let photoURLLarge: URL?
    let photoURLSmall: URL?
    let id: String
    let sourceURL: URL?
    let youtubeURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case id = "uuid"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

// MARK: - Preview Helpers
extension Recipe {
    static let sampleData: Recipe = {
        do {
            return  Recipe(
                cuisine: "British",
                name: "Bakewell Tart",
                photoURLLarge: URL(string: "https://example.com/large.jpg"),
                photoURLSmall: URL(string: "https://example.com/small.jpg"),
                id: "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                sourceURL: URL(string: "https://example.com/recipe"),
                youtubeURL: URL(string: "https://www.youtube.com/watch?v=12345")
            )
        }
    }()
    
    static let sampleDataArray: [Recipe] = [
        sampleData,
    ]
}
