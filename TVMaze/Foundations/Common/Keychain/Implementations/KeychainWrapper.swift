//
//  KeychainWrapper.swift
//  KeychainWrapper
//
//  Created by Jason Rendel on 09/23/2014.
//  Copyright © 2014 Jason Rendel. All rights reserved.
//
//    The MIT License (MIT)
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//
//  swiftlint:disable all

import Foundation
import Security
/// KeychainWrapper is a class to help make Keychain access in Swift more straightforward.
/// It is designed to make accessing the Keychain services more like using NSUserDefaults, which is much more familiar to people.

extension KeychainWrapper: KeychainStorable {}

public final class KeychainWrapper {
    public static let shared = KeychainWrapper()

    private let serviceName = Bundle.main.bundleIdentifier ?? "SwiftKeychainWrapper"

    public func set(_ value: String, forKey key: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        return set(data, forKey: key)
    }

    public func get(_ key: String) -> String? {
        guard let data = getData(forKey: key) else { return nil }
        return String(data: data, encoding: .utf8)
    }

    public func remove(_ key: String) -> Bool {
        let query = baseQuery(forKey: key)
        return SecItemDelete(query as CFDictionary) == errSecSuccess
    }

    public func hasValue(forKey key: String) -> Bool {
        getData(forKey: key) != nil
    }

    public func allKeys() -> Set<String> {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecReturnAttributes as String: true,
            kSecMatchLimit as String: kSecMatchLimitAll
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess, let items = result as? [[String: Any]] else {
            return []
        }

        var keys = Set<String>()
        for item in items {
            if let data = item[kSecAttrAccount as String] as? Data,
               let key = String(data: data, encoding: .utf8) {
                keys.insert(key)
            }
        }

        return keys
    }

    // MARK: - Private Helpers

    private func getData(forKey key: String) -> Data? {
        var query = baseQuery(forKey: key)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnData as String] = true

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        return status == errSecSuccess ? result as? Data : nil
    }

    private func set(_ data: Data, forKey key: String) -> Bool {
        var query = baseQuery(forKey: key)
        query[kSecValueData as String] = data
        query[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlocked

        let status = SecItemAdd(query as CFDictionary, nil)

        if status == errSecDuplicateItem {
            let updateFields = [kSecValueData as String: data]
            return SecItemUpdate(query as CFDictionary, updateFields as CFDictionary) == errSecSuccess
        }

        return status == errSecSuccess
    }

    private func baseQuery(forKey key: String) -> [String: Any] {
        guard let keyData = key.data(using: .utf8) else { return [:] }
        return [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: serviceName,
            kSecAttrAccount as String: keyData,
            kSecAttrGeneric as String: keyData
        ]
    }
}
//  swiftlint:enable all
