//
//  ErrorView.swift
//  RecipeApp
//
//  Created by Mit Sheth on 11/8/24.
//

import SwiftUI

struct ErrorView: View {
    let title: String
    let message: String
    let retryAction: () -> Void
    
    init(
        title: String = "Cannot Load Data",
        message: String,
        retryAction: @escaping () -> Void
    ) {
        self.title = title
        self.message = message
        self.retryAction = retryAction
    }
    
    var body: some View {
        ContentUnavailableView {
            Label(title, systemImage: "exclamationmark.triangle")
        } description: {
            Text(message)
        }
    }
}

#Preview("Modern Error View") {
    ErrorView(
        title: "Cannot Load Recipes",
        message: "Please check your internet connection and try again."
    ) {
        print("Retry tapped")
    }
}
