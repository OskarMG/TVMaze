//
//  DashboardAPIRepository.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import Foundation

public protocol DashboardAPIRepositoring {
    /// `Methods`
    func getShowsBy(page: Int) async throws(NetworkServiceError) -> ShowsResponse
}

public final class DashboardAPIRepository: DashboardAPIRepositoring {
    
    // MARK: - Dependencies

    /// Shared instance used to perform API requests.
    private var networkService = NetworkService.shared

    // MARK: - Initialization

    /// Initializes a new instance of `DashboardAPIRepository`.
    public init() {}

    // MARK: - API Methods
    public func getShowsBy(page: Int) async throws(NetworkServiceError) -> ShowsResponse {
        do throws(NetworkServiceError) {
            let endPoint = DashboardAPIEndPoint.showsBy(page: page)
            let response = try await networkService.request(
                endPoint,
                as: ShowsResponse.self
            )
            return response
        } catch {
            #if DEBUG
            switch error {
            case let .invalidStatusCode(val):
                debugPrint("invalidStatusCode :", val)
            case let .decodingError(error):
                debugPrint("decodingError:", error)
            case let .backendError(data, val):
                debugPrint("backendError:", data, val)
            case let .unknown(error):
                debugPrint("unknown error:", error.localizedDescription)
            }
            #endif
            throw error
        }
    }
}
