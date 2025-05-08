//
//  DashboardViewModel.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 Cencosud. All rights reserved.
//

import Foundation

final class DashboardViewModel: DashboardViewModelProtocol {
    
    @Published var page: Int = .zero
    @Published var shows: ShowsResponse = []
    
    private let dispatchQueue = DispatchQueue.main
    private let repository: DashboardAPIRepositoring
    private var coordinator: (any MainCoordinatable)?
    
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
        if thresholdIndex == item.id {
            page += 1
            getShows()
        }
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
                self.shows.append(contentsOf: result)
            } catch {
              /// Handle Error || Show Error State
            }
        }
    }
}
