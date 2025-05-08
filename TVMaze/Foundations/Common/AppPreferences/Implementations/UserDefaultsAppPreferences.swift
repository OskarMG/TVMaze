//
//  UserDefaultsAppPreferences.swift
//  Common
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import Foundation

/// A concrete implementation of `AppPreferences` that uses `UserDefaults`
/// to persist lightweight user-specific app settings.
///
/// This class handles simple preference flags and values such as biometric preference.
/// It provides a lightweight, dependency-injectable way to manage persistent app state.
public final class UserDefaultsAppPreferences: AppPreferences {
    /// The underlying `UserDefaults` storage used to persist and retrieve values.
    private let defaults: UserDefaults
    
    private enum Keys {
        static let biometrics = "biometrics"
    }

    /// Initializes a new instance of `UserDefaultsAppPreferences`.
    ///
    /// - Parameter defaults: The `UserDefaults` instance to use. Defaults to `.standard`.
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    /// A Boolean value indicating whether the user is using biometrics .
    ///
    /// Used to determine whether to login using biometrics or not.
    public var isUsingBiometric: Bool {
        get { defaults.bool(forKey: Keys.biometrics) }
        set { defaults.set(newValue, forKey: Keys.biometrics) }
    }
}
