//
//  TMSearchBar.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

/// A reusable search bar component with a search icon, clear button, and customizable input binding.
/// Designed for use in search/filter interfaces.
struct TMSearchBar: View {
    
    /// The bound search text input.
    @Binding private var input: String

    /// Initializes a `TMSearchBar`.
    /// - Parameter input: A `Binding<String>` to the text field's value.
    init(input: Binding<String>) {
        self._input = input
    }

    var body: some View {
        HStack(spacing: .zero) {
            TextField(String.placeholder, text: $input)
                .padding(.padding10)
                .padding(.leading, .padding20)
                .background(Color(.systemGray6))
                .cornerRadius(.cornerRadius)
                .overlay(searchIcon)
                .overlay(alignment: .trailing, content: clearButton)
        }
        .padding(.top, .padding10)
    }

    /// A magnifying glass icon displayed inside the leading edge of the text field.
    private var searchIcon: some View {
        HStack(spacing: .zero) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .frame(minWidth: .zero, maxWidth: .infinity, alignment: .leading)
                .padding(.leading, .padding8)
        }
    }

    /// A clear ("X") button shown when the input is not empty, allowing the user to clear the search field.
    @ViewBuilder
    private func clearButton() -> some View {
        if !input.isEmpty {
            Button(action: { input = "" }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .padding(.trailing, .padding10)
            }
        }
    }
}

// MARK: - Constants

private extension String {
    static let placeholder = "Search..."
}

private extension CGFloat {
    static let padding8: CGFloat = 8
    static let padding20: CGFloat = 20
    static let padding10: CGFloat = 10
    static let cornerRadius: CGFloat = 8
}
