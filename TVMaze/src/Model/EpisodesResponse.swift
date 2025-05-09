//
//  EpisodesResponse.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

public typealias EpisodesResponse = [Episode]

public struct Episode: Codable, Identifiable {
    public let id: Int
    let url: String
    let season: Int
    let name: String
    let number: Int?
    let image: Poster?
    let summary: String?

    enum CodingKeys: String, CodingKey {
        case id,
             url,
             name,
             image,
             season,
             number,
             summary
    }
}

