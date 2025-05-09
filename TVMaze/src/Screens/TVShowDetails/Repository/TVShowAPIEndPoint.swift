//
//  TVShowAPIEndPoint.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import Foundation

public enum TVShowAPIEndPoint: APIEndPoint {
    
    case seasonsFor(tvShowId: Int)
    case episodesFor(seasonId: Int)
    case episodeFor(showId: Int, season: Int, episode: Int)

    public var baseURL: URL { EnvironmentConfig.apiUrl }
    public var headers: [String : String]? { return nil }
    public var method: HTTPMethod { return .get }
    
    public var parameters: [String : Any]? {
        switch self {
        case .seasonsFor, .episodesFor:
            return nil
        case let .episodeFor(_, season, episode):
            return [
                "number": episode,
                "season": season
            ]
        }
    }
    
    public var path: String {
        switch self {
        case .seasonsFor(let tvShowId):
            "shows/\(tvShowId)/seasons"
        case .episodesFor(let seasonId):
            "seasons/\(seasonId)/episodes"
        case let .episodeFor(showId, _, _):
            "shows/\(showId)/episodebynumber"
        }
    }
}
