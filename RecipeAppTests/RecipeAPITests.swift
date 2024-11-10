//
//  RecipeAPITests.swift
//  RecipeApp
//
//  Created by Mit Sheth on 11/10/24.
//

import XCTest
@testable import RecipeApp

final class RecipeAPITests: XCTestCase {
    // MARK: - Properties
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let networkingLayer: NetworkingAPI = NetworkingLayer()
    private let recipesURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    // MARK: - Decoding Tests
    func testDecodingSampleRecipeResponse() throws {
        // Given sample JSON matches your data structure
        let sampleJSON = """
        {
            "recipes": [
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "photoURLLarge": "https://some.url/large.jpg",
                    "photo_url_small": "https://some.url/small.jpg",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "source_url": "https://some.url/index.html",
                    "youtube_url": "https://www.youtube.com/watch?v=some.id"
                }
            ]
        }
        """

        // When
        do {
            let recipeResponse = try decoder.decode(RecipeResponse.self, from: sampleJSON.data(using: .utf8)!)
            // Then
            XCTAssertFalse(recipeResponse.recipes.isEmpty)
            XCTAssertEqual(recipeResponse.recipes.first?.name, "Bakewell Tart")
            XCTAssertEqual(recipeResponse.recipes.first?.cuisine, "British")
            // Add more tests for other properties
        } catch {
            XCTFail("Decoding failed: \(error)")
        }
    }
    
    // MARK: - API Integration Tests
    func testRequestAndDecodeRecipesAPI() async throws {
        let response: RecipeResponse = try await networkingLayer.request(recipesURL)
        XCTAssertFalse(response.recipes.isEmpty)
    }
}
