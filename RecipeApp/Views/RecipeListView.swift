//
//  RecipeListView.swift
//  RecipeApp
//
//  Created by Mit Sheth on 11/8/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    
    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .idle, .loading:
                LoadingView("Loading recipes...")
                
            case .loaded(_):
                recipeList
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                Task {
                                    await viewModel.fetchRecipes()
                                    print("Refresh button tapped")
                                }
                            } label: {
                                Image(systemName: "arrow.clockwise")
                            }
                            .disabled(viewModel.loadingState == .loading)
                        }
                    }
                
            case .error(let message):
                ErrorView(
                    title: "Cannot Load Recipes",
                    message: message
                ) {
                    Task {
                        await viewModel.fetchRecipes()
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search by name or cuisine")
        .task {
            // Only fetch if we haven't loaded recipes yet
            if case .idle = viewModel.loadingState {
                await viewModel.fetchRecipes()
            }
        }
    }
    
    private var recipeList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                if viewModel.searchResults.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchText)
                } else {
                    ForEach(viewModel.searchResults) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeItemView(recipe: recipe)
                                .padding(.horizontal)
                        }
                        Divider()
                            .padding(.horizontal)
                    }
                }
            }
            .padding(.vertical)
        }
    }
}

#Preview {
    RecipeListView()
}
