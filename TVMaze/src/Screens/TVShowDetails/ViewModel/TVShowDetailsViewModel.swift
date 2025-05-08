//
//  TVShowDetailsViewModel.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import Foundation

final class TVShowDetailsViewModel: TVShowDetailsViewModelProtocol {
    
    private let tvShow: TVShow
    private var seasons: SeasonResponse = []
    private let repository: TVShowDetailsAPIRepositoring
    private weak var coordinator: (any MainCoordinatable)?
    
    var tvShowName: String { tvShow.name }
    var genders: [String] { tvShow.genres }
    var bannerUrl: String? { tvShow.image?.original }
    var summary: String? { tvShow.summary?.removeHTMLTags() }
    var rate: String { "\(tvShow.rating.average ?? .zero)" }
    
    var schedule: String {
        let days = tvShow.schedule.days.map {$0.rawValue}
        return "\(days.joined(separator: ", ")) | \(tvShow.schedule.time)"
    }

    @Published var episodesPerSeason: [EpisodesResponse] = []
    
    init(
        tvShow: TVShow,
        repository: TVShowDetailsAPIRepositoring = TVShowDetailsAPIRepository(),
        coordinator: (any MainCoordinatable)?
    ) {
        self.tvShow = tvShow
        self.repository = repository
        self.coordinator = coordinator
        
        getSeasons()
    }
    
    func getSeasons() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let result = try await repository.getSeasonsFor(tvShowId: tvShow.id)
                seasons = result
                getEpisodesForSeason()
            } catch {
                /// Handle Error || show error State
            }
        }
    }
    
    func getEpisodesForSeason() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                for season in seasons {
                    let result = try await repository.getEpisodesFor(seasonId: season.id)
                    episodesPerSeason.append(result)
                }
            } catch {
                /// Handle Error || show error State
            }
        }
    }
}
