//
//  String+Ext.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

public extension String {
    func removeHTMLTags() -> String {
        let pattern = "<[^>]+>"
        return self.replacingOccurrences(of: pattern, with: "", options: .regularExpression)
    }
}
