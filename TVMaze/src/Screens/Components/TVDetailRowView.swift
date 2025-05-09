//
//  TVDetailRowView.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

/// A reusable row view used to display a labeled piece of information in a TV detail screen.
/// Includes an icon, a label, and a value aligned horizontally with styling and a bottom divider.
struct TVDetailRowView: View {

    /// The row type, containing an icon and a label.
    let row: TMIRow

    /// The value to display next to the label.
    let value: String

    /// Initializes a `TVDetailRowView` with a single string value.
    /// - Parameters:
    ///   - row: The metadata row containing icon and label.
    ///   - value: The string value to show.
    init(row: TMIRow, value: String) {
        self.row = row
        self.value = value
    }

    /// Initializes a `TVDetailRowView` with an array of strings.
    /// The array values will be joined with a comma separator.
    /// - Parameters:
    ///   - row: The metadata row containing icon and label.
    ///   - value: The array of string values to show.
    init(row: TMIRow, value: [String]) {
        self.row = row
        self.value = value.joined(separator: ", ")
    }

    var body: some View {
        HStack(spacing: .padding8) {
            // Icon
            row.icon
                .foregroundColor(.greenGray)
                .frame(width: .iconSize, height: .iconSize)
                .scaledToFill()
            
            // Label
            Text(row.label)
                .bold()
                .foregroundColor(.primary)
            
            Spacer()

            // Value
            Text(value)
        }
        .padding(.top, .padding8)
        .padding(.bottom, .padding16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(alignment: .bottom, content: setupDivider)
    }

    /// Bottom divider under the row for visual separation.
    private func setupDivider() -> some View {
        Rectangle()
            .foregroundColor(.secondary.opacity(.opacity))
            .frame(height: .dividerHeight)
    }
}

// MARK: - Constant

private extension Double {
    static let opacity: Double = 0.25
}

private extension CGFloat {
    static let padding8: CGFloat = 8
    static let iconSize: CGFloat = 24
    static let padding16: CGFloat = 16
    static let dividerHeight: CGFloat = 1
}
