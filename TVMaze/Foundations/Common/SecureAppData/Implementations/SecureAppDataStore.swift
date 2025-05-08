//
//  Secure.swift
//  Common
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

/// A concrete implementation of `SecureAppDataStorable` that leverages
/// a `KeychainStorable` instance to securely store sensitive app data.
///
/// This class acts as a lightweight wrapper around Keychain functionality.
public final class SecureAppDataStore: SecureAppDataStorable {
    /// The underlying keychain interface used for secure data operations.
    private let keychain: KeychainStorable

    /// Creates a new secure data store using the specified keychain.
    ///
    /// - Parameter keychain: The keychain instance to use. Defaults to the shared instance.
    public init(keychain: KeychainStorable = KeychainWrapper.shared) {
        self.keychain = keychain
    }

    /// Saves a string value securely for a given key.
    ///
    /// - Parameters:
    ///   - value: The string value to store.
    ///   - key: The key associated with the value.
    /// - Returns: A Boolean indicating whether the operation was successful.
    public func save(_ value: String, for key: SecureAppDataKey) -> Bool {
        keychain.set(value, forKey: key.rawValue)
    }

    /// Reads a stored string value for a given key.
    ///
    /// - Parameter key: The key whose associated value is to be retrieved.
    /// - Returns: The stored string value, or `nil` if no value is found.
    public func read(for key: SecureAppDataKey) -> String? {
        keychain.get(key.rawValue)
    }

    /// Deletes the value associated with a given key.
    ///
    /// - Parameter key: The key to remove from secure storage.
    /// - Returns: A Boolean indicating whether the deletion was successful.
    public func delete(for key: SecureAppDataKey) -> Bool {
        keychain.remove(key.rawValue)
    }

    /// Checks whether a value exists for the given key.
    ///
    /// - Parameter key: The key to check in secure storage.
    /// - Returns: `true` if a value exists, otherwise `false`.
    public func exists(_ key: SecureAppDataKey) -> Bool {
        keychain.hasValue(forKey: key.rawValue)
    }
}
