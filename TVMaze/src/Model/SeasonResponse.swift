//
//  SeasonResponse.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

public typealias SeasonResponse = [Season]

public struct Season: Codable {
    let id: Int
    let url: String
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id, url, name
    }
}
