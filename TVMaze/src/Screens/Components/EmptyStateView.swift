//
//  EmptyStateView.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

/// A struct that defines an action to be displayed in the `EmptyStateView`, including a label and a closure to execute.
struct EmptyStateAction {
    /// The text to display on the action button.
    let label: String
    /// The closure to execute when the action button is tapped.
    let action: () -> Void
}

/// A reusable view that represents an empty state in the UI,
/// typically used when no content is available after filtering or loading.
struct EmptyStateView: View {
    /// The name of the system image to display as an icon. Optional.
    var icon: String?
    
    /// The message describing the empty state.
    var message: String
    
    /// The color used to tint the icon and text.
    var tint: Color
    
    /// An optional action with a button and callback to be displayed below the message.
    let action: EmptyStateAction?
    
    /// Creates a new `EmptyStateView`.
    /// - Parameters:
    ///   - icon: Optional system image name (SF Symbols).
    ///   - message: Descriptive message to show.
    ///   - tint: Tint color for the icon and text. Defaults to `.greenGray`.
    ///   - action: Optional action with label and handler.
    init(
        icon: String? = nil,
        message: String,
        tint: Color = .greenGray,
        action: EmptyStateAction? = nil
    ) {
        self.icon = icon
        self.message = message
        self.tint = tint
        self.action = action
    }

    var body: some View {
        VStack(spacing: .padding12) {
            if let icon {
                Image(systemName: icon)
                    .font(.system(size: .size20))
                    .foregroundColor(tint.opacity(.opacity))
                    .padding()
            }

            Text(message)
                .font(.headline)
                .foregroundColor(tint)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if let action {
                Button(action: action.action) {
                    Text(action.label)
                        .foregroundColor(tint)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.clear)
    }
}

// MARK: - Constants

private extension Double {
    static let opacity: Double = 0.6
}

private extension CGFloat {
    static let size20: CGFloat = 40
    static let padding12: CGFloat = 12
}
