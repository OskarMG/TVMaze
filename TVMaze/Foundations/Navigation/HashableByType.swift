//
//  HashableByType.swift
//  Navigation
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

public protocol IdentifiableByType: Identifiable {}

public extension IdentifiableByType {
    /// The default identifier based on the type name
    var id: String {
        String(describing: self.self)
    }
}

public protocol HashableByType: IdentifiableByType, Hashable {}

public extension HashableByType {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
