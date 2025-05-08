//
//  Configuration.swift
//  Common
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

/// Provides a utility for accessing configuration values
/// defined in the app's Info.plist file.
struct Configuration {
    /// Retrieves the string value for the given key from the Info.plist.
    ///
    /// - Parameter key: The key to look up in the Info.plist.
    /// - Returns: The associated string value if it exists, or an empty string otherwise.
    static func value(for key: String) -> String {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) as? String else { return "" }
        return object
    }
}
