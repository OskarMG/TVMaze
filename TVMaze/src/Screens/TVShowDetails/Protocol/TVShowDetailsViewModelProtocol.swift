//
//  TVShowDetailsViewModelProtocol.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import Combine

protocol TVShowDetailsViewModelProtocol: AnyObject, ObservableObject, SeasonCarouselDelegate {
    var rate: String { get }
    var tvShowName: String { get }
    var summary: String? { get }
    var genders: [String] { get }
    var schedule: String { get }
    var bannerUrl: String? { get }
    var episodesPerSeason: [EpisodesResponse] { get }
}
