//
//  TVShowDetailsAPIRepository.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import Foundation

public protocol TVShowDetailsAPIRepositoring {
    /// `Methods`
    func getSeasonsFor(tvShowId: Int) async throws(NetworkServiceError) -> SeasonResponse
    func getEpisodesFor(seasonId: Int) async throws(NetworkServiceError) -> EpisodesResponse
}

public final class TVShowDetailsAPIRepository: TVShowDetailsAPIRepositoring {
    
    // MARK: - Dependencies

    /// Shared instance used to perform API requests.
    private var networkService = NetworkService.shared

    // MARK: - Initialization

    /// Initializes a new instance of `TVShowDetailsAPIRepository`.
    public init() {}
    
    private func debugError(_ error: NetworkServiceError) {
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
    }

    // MARK: - API Methods
    public func getSeasonsFor(tvShowId: Int) async throws(NetworkServiceError) -> SeasonResponse {
        do throws(NetworkServiceError) {
            let endPoint = TVShowAPIEndPoint.seasonsFor(tvShowId: tvShowId)
            let response = try await networkService.request(
                endPoint,
                as: SeasonResponse.self
            )
            return response
        } catch {
            debugError(error)
            throw error
        }
    }
    
    public func getEpisodesFor(seasonId: Int) async throws(NetworkServiceError) -> EpisodesResponse {
        do throws(NetworkServiceError) {
            let endPoint = TVShowAPIEndPoint.episodesFor(seasonId: seasonId)
            let response = try await networkService.request(
                endPoint,
                as: EpisodesResponse.self
            )
            return response
        } catch {
            debugError(error)
            throw error
        }
    }
}
