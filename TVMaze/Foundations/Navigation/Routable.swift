//
//  Routeable.swift
//  Navigation
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

/// Protocol that defines a type-safe, hashable route for navigation within the coordinator system.
///
/// `Routable` is designed to be implemented by `enum` types that define specific navigation routes.
/// By conforming to `HashableByType`, each case in the `enum` can be uniquely identified, which
/// is essential for navigation in complex applications.
///
/// - Note: **Intended for use only in `enum` types.** Implementing this protocol in other types
///   (such as classes or structs) may cause unexpected behavior or errors within the coordinator's
///   navigation system.
///
/// Usage:
/// ```
/// enum AppRoute: Routable {
///     case home
///     case details(id: Int)
///     case settings
/// }
/// ```
///
/// This protocol is especially useful when combined with the coordinator pattern, as it enables
/// seamless type-safe navigation throughout the app's view hierarchy.
///
/// Requirements:
/// - The conforming type must be an `enum` to ensure proper functionality.
/// - Each case of the `enum` should represent a unique navigable route in the application.
public protocol Routable: HashableByType {}
