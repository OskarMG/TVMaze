//
//  PresentationType.swift
//  Navigation
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import SwiftUI

/// Defines the types of presentations available for modally presenting views.
///
/// - fullScreen: Presents the view in full-screen mode, covering the entire screen.
/// - sheet(detents: [PresentationDetent]): Presents the view as a resizable sheet with specific detents,
///   which control the sheet’s height at different sizes (e.g., `.medium`, `.large`).
public enum PresentationType {
    case fullScreen
    case sheet(detents: Set<PresentationDetent>? = nil, dragIndicator: Visibility = .automatic)
}

// swiftlint: disable switch_case_on_newline switch_case_alignment
extension PresentationType {
    /// Compares two `PresentationType` instances for equality, ignoring sheet detents.
    ///
    /// This equality check considers `.sheet` types as equal regardless of their detents,
    /// and matches `.fullScreen` types exactly.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side `PresentationType` to compare.
    ///   - rhs: The right-hand side `PresentationType` to compare.
    /// - Returns: `true` if both types are either `.sheet` (ignoring detents) or both are `.fullScreen`.
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case (.sheet, .sheet): return true
            case (.fullScreen, .fullScreen): return true
            default: return false
        }
    }

    /// Provides access to the detents associated with a `.sheet` type.
    ///
    /// - Returns: The `Set<PresentationDetent>` if the instance is a `.sheet` type, or `nil` if not.
    var detents: Set<PresentationDetent>? {
        guard case .sheet(let detents, _) = self else {
            return nil
        }
        return detents
    }

    /// Provides access to the dragIndicator associated with a `.sheet` type.
    ///
    /// - Returns: The `Visibility` if the instance is a `.sheet` type, or `nil` if not.
    var dragIndicator: Visibility? {
        guard case .sheet(_, let indicator) = self else {
            return nil
        }
        return indicator
    }
}
// swiftlint: enable switch_case_on_newline switch_case_alignment
