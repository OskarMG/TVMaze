//
//  LoadingView.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

/// A reusable loading view with customizable size, tint color, and optional title.
/// Typically used to indicate that background work is in progress.
struct LoadingView: View {
    
    /// Defines the visual size of the loading spinner.
    enum Size {
        case small, medium, large
        
        /// The scale factor to apply to the progress indicator.
        var scale: CGFloat {
            switch self {
            case .small: return 0.75
            case .medium: return 1.0
            case .large: return 1.5
            }
        }
        
        /// The frame dimensions (width/height) of the loading indicator.
        var frame: CGFloat {
            switch self {
            case .small: return 20
            case .medium: return 30
            case .large: return 50
            }
        }
    }

    /// The tint color for the spinner and optional title text.
    var tint: Color = .greenGray
    
    /// The visual size of the spinner. Defaults to `.medium`.
    var size: Size = .medium
    
    /// An optional string to display below the spinner (e.g., "Loading...").
    var title: String? = nil

    var body: some View {
        VStack(spacing: .padding8) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: tint))
                .frame(width: size.frame, height: size.frame)
                .scaleEffect(size.scale)
                .padding()
                .background(Color(tint).opacity(.opacity1))
                .clipShape(Circle())
                .shadow(color: tint.opacity(.opacity3), radius: .radiusX, x: .zero, y: .radiusY)

            if let title {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(tint)
            }
        }
    }
}

// MARK: - Constants

private extension Double {
    static let opacity1: Double = 0.1
    static let opacity3: Double = 0.3
}

private extension CGFloat {
    static let radiusY: CGFloat = 2
    static let radiusX: CGFloat = 4
    static let padding8: CGFloat = 8
}
