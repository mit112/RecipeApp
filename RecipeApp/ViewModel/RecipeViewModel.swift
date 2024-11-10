//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Mit Sheth on 11/8/24.
//

import Foundation

@MainActor
final class RecipeListViewModel: ObservableObject {
    private let networkingLayer: NetworkingAPI = NetworkingLayer()
    @Published private(set) var recipesData: [Recipe] = []
    @Published private(set) var loadingState: LoadingState = .idle
    @Published var searchText: String = "" {
        didSet {
            updateSearchResults()
        }
    }
    
    @Published private(set) var searchResults: [Recipe] = []
    
    private let recipesURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    private let malformedURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
    private let emptyDataURL = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    
    enum LoadingState: Equatable {
        case idle
        case loading
        case loaded(Int) // number of recipes loaded
        case error(String) // simplified error message
    }
    
    func fetchRecipes() async {
        guard loadingState != .loading else { return }
        
        loadingState = .loading
        
        do {
            let response: RecipeResponse = try await networkingLayer.request(recipesURL)
            
            // Handle empty data case
            guard !response.recipes.isEmpty else {
                loadingState = .error("We're working on bringing you the best recipes! Stay tuned!")
                recipesData = []
                searchResults = []
                return
            }
            
            recipesData = response.recipes.sorted { $0.name < $1.name }
            searchResults = recipesData
            loadingState = .loaded(recipesData.count)
            // This is not working as expected
        } catch {
            recipesData = []
            searchResults = []
            loadingState = .error("Oops, we got the measurements wrong. We'll fix it right away.")
        }
    }
    
    private func updateSearchResults() {
        if searchText.isEmpty {
            searchResults = recipesData
        } else {
            searchResults = recipesData.filter { recipe in
                recipe.name.localizedCaseInsensitiveContains(searchText) ||
                recipe.cuisine.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
