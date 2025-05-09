//
//  FilteredTVShowsResponse.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

public typealias FilteredTVShowsResponse = [FilteredTVShow]

public struct FilteredTVShow: Codable {
    let score: Double
    let show: TVShow?
}
