//
//  RecipeDetailView.swift
//  RecipeApp
//
//  Created by Mit Sheth on 11/9/24.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Title and Cuisine
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(recipe.cuisine)
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 8)
                
                // Large Image with Card Style
                if let photoURLLarge = recipe.photoURLLarge {
                    ImageView(imageUrl: photoURLLarge, placeholderImage: UIImage(named: "Default-Photo"))
                        .frame(maxWidth: .infinity, minHeight: 200) // Larger image
                        .aspectRatio(contentMode: .fill)
//                        .clipped()
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
                        .padding(.bottom, 8)
                }
                
                // Source Link
                if let sourceURL = recipe.sourceURL {
                    Link(destination: sourceURL) {
                        HStack {
                            Image(systemName: "link.circle")
                                .foregroundColor(.blue)
                            Text("Source")
                                .font(.body)
                                .underline()
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                // YouTube Link
                if let youtubeURL = recipe.youtubeURL {
                    Link(destination: youtubeURL) {
                        HStack {
                            Image(systemName: "play.circle.fill")
                                .foregroundColor(.red)
                            Text("Watch on YouTube")
                                .font(.body)
                                .underline()
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.vertical, 4)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    RecipeDetailView(recipe: Recipe.sampleData)
}
