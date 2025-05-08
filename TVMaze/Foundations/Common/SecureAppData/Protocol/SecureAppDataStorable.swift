//
//  SecureAppDataStorable.swift
//  Common
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

/// Defines a secure storage interface for sensitive application data,
/// such as user tokens or identifiers, typically backed by Keychain or similar services.
public protocol SecureAppDataStorable: AnyObject {
    /// Saves a string value securely for a given key.
    ///
    /// - Parameters:
    ///   - value: The string value to store.
    ///   - key: The key associated with the value.
    /// - Returns: A Boolean indicating whether the operation was successful.
    func save(_ value: String, for key: SecureAppDataKey) -> Bool

    /// Reads a stored string value for a given key.
    ///
    /// - Parameter key: The key whose associated value is to be retrieved.
    /// - Returns: The stored string value, or `nil` if no value is found.
    func read(for key: SecureAppDataKey) -> String?

    /// Deletes the value associated with a given key.
    ///
    /// - Parameter key: The key to remove from secure storage.
    /// - Returns: A Boolean indicating whether the deletion was successful.
    func delete(for key: SecureAppDataKey) -> Bool

    /// Checks whether a value exists for the given key.
    ///
    /// - Parameter key: The key to check in secure storage.
    /// - Returns: `true` if a value exists, otherwise `false`.
    func exists(_ key: SecureAppDataKey) -> Bool
}
