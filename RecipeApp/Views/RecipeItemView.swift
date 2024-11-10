//
//  RecipeCardView.swift
//  RecipeApp
//
//  Created by Mit Sheth on 11/8/24.
//

import SwiftUI

struct RecipeItemView: View {
    let recipe: Recipe
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 10) {
                ImageView(imageUrl: recipe.photoURLSmall ?? URL(string: "")!, placeholderImage: UIImage(named: "Default-Photo"))
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(recipe.name)
                        .font(.headline)
                        .foregroundColor(.primary) // Adapts to dark mode
                    
                    Text(recipe.cuisine)
                        .font(.subheadline)
                        .foregroundColor(.secondary) // Adapts to dark mode
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground)) // Adaptive background
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 3)
        .padding(.horizontal, 8)
    }
}
