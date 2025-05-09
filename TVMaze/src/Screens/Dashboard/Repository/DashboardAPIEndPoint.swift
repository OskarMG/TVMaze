//
//  DashboardAPIEndPoint.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

public enum DashboardAPIEndPoint: APIEndPoint {
    
    case showsBy(page: Int)
    case getShowsFor(String)

    public var baseURL: URL { EnvironmentConfig.apiUrl }
    public var headers: [String : String]? { return nil }
    public var method: HTTPMethod { return .get }
    
    public var parameters: [String : Any]? {
        switch self {
        case let .showsBy(page):
            ["page": page]
        case let .getShowsFor(query):
            ["q": query]
        }
    }
    
    public var path: String {
        switch self {
        case .showsBy:
            "shows"
        case .getShowsFor:
            "search/shows"
        }
    }
}
