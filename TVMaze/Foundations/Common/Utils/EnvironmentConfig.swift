//
//  Environment.swift
//  Common
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

// swiftlint: disable force_unwrapping
/// A utility struct for accessing environment-specific configuration values
/// such as base URLs and network schemes from the app's Info.plist.
public struct EnvironmentConfig {
    /// The base URL (host) for API requests, retrieved from the `API_BASE_URL` key in Info.plist.
    static var apiBaseUrl: String {
        Configuration.value(for: "API_BASE_URL")
    }

    /// The scheme used for API requests (e.g., `https`), retrieved from the `API_SCHEME` key in Info.plist.
    static var apiScheme: String {
        Configuration.value(for: "API_SCHEME")
    }

    /// The scheme used for API requests (e.g., `https`), retrieved from the `API_SCHEME` key in Info.plist.
    static var encryptSecret: String {
        Configuration.value(for: "ENCRYPT_SECRET")
    }

    /// A computed URL composed of the scheme and base URL.
    ///
    /// - Warning: The app will crash if the resulting URL is invalid.
    public static var apiUrl: URL {
        URL(string: "\(EnvironmentConfig.apiScheme)://\(EnvironmentConfig.apiBaseUrl)")!
    }
}
// swiftlint: enable force_unwrapping
