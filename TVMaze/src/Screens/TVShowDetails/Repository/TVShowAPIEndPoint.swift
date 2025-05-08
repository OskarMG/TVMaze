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

    public var baseURL: URL { EnvironmentConfig.apiUrl }
    public var headers: [String : String]? { return nil }
    public var method: HTTPMethod { return .get }
    
    public var parameters: [String : Any]? {
        switch self {
        case .seasonsFor, .episodesFor:
            return nil
        }
    }
    
    public var path: String {
        switch self {
        case .seasonsFor(let tvShowId):
            "shows/\(tvShowId)/seasons"
        case .episodesFor(let seasonId):
            "seasons/\(seasonId)/episodes"
        }
    }
}
