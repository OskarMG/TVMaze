//
//  DashboardViewModelProtocol.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import Combine

protocol DashboardViewModelProtocol: AnyObject, ObservableObject {
    var isFiltering: Bool { get }
    var shows: ShowsResponse { get }
    var searchInput: String { get set }
    var filteredShows: ShowsResponse { get }
    var stateView: DashboardStateView { get }
    var showEmptyStateVisibleForFilter: Bool { get }
    /// `Methods`
    func onTryAgain()
    func nextPage(_ item: TVShow)
    func onTvShowTap(_ tvShow: TVShow)
}
