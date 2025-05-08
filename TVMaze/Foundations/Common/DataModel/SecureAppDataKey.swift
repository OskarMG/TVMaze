//
//  SecureAppDataKey.swift
//  Common
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

/// Represents the set of keys used to securely store sensitive data
/// in the app's keychain or secure storage system.
public enum SecureAppDataKey: String {
    /// Key used to store the user's PIN
    case userPin

    /// Key used to store the user's authentication token.
    case authToken

    /// Key used to store the user's refresh token.
    case refreshToken

    /// Key used to store a unique identifier for the user.
    case userIdentifier
}
