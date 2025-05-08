//
//  DashboardViewModel.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import Foundation

final class DashboardViewModel: DashboardViewModelProtocol {
    
    @Published var page: Int = .zero
    @Published var shows: ShowsResponse = []
    
    /// `itemsPerPage` must be multiple of `maxItemsPerPage`
    /// - For exmaple: 250 % 25 = 0
    private let itemsPerPage: Int = 10
    private let maxItemsPerPage: Int = 250
    private var currentPageChunkIndex = 0
    private let dispatchQueue = DispatchQueue.main
    private let repository: DashboardAPIRepositoring
    private weak var coordinator: (any MainCoordinatable)?
    
    init(
        apiRepository: DashboardAPIRepositoring = DashboardAPIRepository(),
        coordinator: (any MainCoordinatable)? = nil
    ) {
        self.coordinator = coordinator
        self.repository = apiRepository
    }
    
    func onAppear() {
        getShows()
    }
    
    func nextPage(_ item: TVShow) {
        let thresholdIndex = shows.index(shows.endIndex, offsetBy: -1)
        if thresholdIndex == item.id { getShows() }
    }
    
    func onTvShowTap(_ tvShow: TVShow) {
        dispatchQueue.async {
            self.coordinator?.didTapOnTvShow(tvShow)
        }
    }
    
    // MARK: - API Methods
    private func getShows() {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let result = try await repository.getShowsBy(page: page)
                
                let start = currentPageChunkIndex * itemsPerPage
                let end = min(start + itemsPerPage, result.count)
                
                guard start < end else {
                    self.page += 1
                    self.currentPageChunkIndex = .zero
                    self.getShows() /// `recursively` call to fetch the next page
                    return
                }

                let nextChunk = Array(result[start..<end])
                self.shows.append(contentsOf: nextChunk)
                self.currentPageChunkIndex += 1
            } catch {
              /// Handle Error || Show Error State
            }
        }
    }
}
