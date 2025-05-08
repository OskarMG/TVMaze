//
//  AppPreferences.swift
//  Common
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

/// A protocol that defines an interface for accessing and storing app-level user preferences.
///
/// `AppPreferences` provides a standardized way to manage simple, persistent user settings.
/// These preferences are typically stored using `UserDefaults` or another local persistence mechanism.
public protocol AppPreferences: AnyObject {
    /// Indicates whether the user has already completed the onboarding flow.
    ///
    /// Use this value to determine if the biometric icon should be shown.
    var isUsingBiometric: Bool { get set }
}
