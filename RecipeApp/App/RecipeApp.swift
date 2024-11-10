//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Mit Sheth on 11/8/24.
//

import SwiftUI

@main
struct RecipeApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RecipeListView()
                    .navigationTitle("Recipe App")
            }
        }
    }
}
