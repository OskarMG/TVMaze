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
    private weak var coordinator: (any MainCoordinatable)?
    
    var tvShowName: String { tvShow.name }
    var summary: String? { tvShow.summary?.removeHTMLTags() }
    var genders: [String] { tvShow.genres }
    var schedule: String {
        let days = tvShow.schedule.days.map {$0.rawValue}
        return "\(days.joined(separator: ", ")) | \(tvShow.schedule.time)"
    }
    var bannerUrl: String? { tvShow.image?.original }
    var rate: String { "\(tvShow.rating.average ?? .zero)" }
    
    init(
        tvShow: TVShow,
        coordinator: (any MainCoordinatable)?
    ) {
        self.tvShow = tvShow
        self.coordinator = coordinator
    }
}
