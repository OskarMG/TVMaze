//
//  Keychain.swift
//  Common
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

/// Defines a contract for securely storing and retrieving sensitive data
/// using a key-value interface, typically backed by the system keychain.
public protocol KeychainStorable: AnyObject {
    /// Stores a string value for a given key in the secure storage.
    ///
    /// - Parameters:
    ///   - value: The string value to store.
    ///   - key: The key under which the value will be stored.
    /// - Returns: `true` if the operation was successful, otherwise `false`.
    func set(_ value: String, forKey key: String) -> Bool

    /// Retrieves the string value associated with the specified key.
    ///
    /// - Parameter key: The key whose value should be retrieved.
    /// - Returns: The value if it exists, or `nil` if not found.
    func get(_ key: String) -> String?

    /// Removes the value associated with the specified key.
    ///
    /// - Parameter key: The key whose value should be removed.
    /// - Returns: `true` if the deletion was successful, otherwise `false`.
    func remove(_ key: String) -> Bool

    /// Determines whether a value exists for the given key.
    ///
    /// - Parameter key: The key to check.
    /// - Returns: `true` if a value exists, otherwise `false`.
    func hasValue(forKey key: String) -> Bool

    /// Returns all keys currently stored in the secure storage.
    ///
    /// - Returns: A set of keys as `String` values.
    func allKeys() -> Set<String>
}
