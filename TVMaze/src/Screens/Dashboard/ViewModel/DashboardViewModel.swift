//
//  DashboardViewModel.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import Combine
import Foundation

enum DashboardStateView {
    case error
    case loading
    case content
}

final class DashboardViewModel: DashboardViewModelProtocol {
    @Published var page: Int = .zero
    @Published var searchInput: String = ""
    @Published var shows: ShowsResponse = []
    @Published var filteredShows: ShowsResponse = []
    @Published var stateView: DashboardStateView = .loading
    
    @Published var showEmptyStateVisibleForFilter: Bool = false
    
    private let dispatchQueue = DispatchQueue.main
    private let repository: DashboardAPIRepositoring
    private var cancellables = Set<AnyCancellable>()
    private weak var coordinator: (any MainCoordinatable)?
    
    var isFiltering: Bool { !searchInput.isEmpty }
    
    init(
        apiRepository: DashboardAPIRepositoring = DashboardAPIRepository(),
        coordinator: (any MainCoordinatable)? = nil
    ) {
        self.coordinator = coordinator
        self.repository = apiRepository
        setupListeners()
        getShows()
    }
    
    func setupListeners() {
        $searchInput
            .debounce(for: .seconds(0.2), scheduler: dispatchQueue)
            .removeDuplicates()
            .sink(receiveValue: onSearchFor(_:))
            .store(in: &cancellables)
    }
    
    func onSearchFor(_ newQuery: String) {
        guard !newQuery.isEmpty else { return }
        getShow(for: newQuery)
    }
    
    func nextPage(_ item: TVShow) {
        guard !isFiltering else { return }
        let thresholdIndex = shows.index(shows.endIndex, offsetBy: -1)
        if thresholdIndex == item.id { getShows() }
    }
    
    func onTvShowTap(_ tvShow: TVShow) {
        dispatchQueue.async {
            self.coordinator?.didTapOnTvShow(tvShow)
        }
    }
    
    func onTryAgain() { resetState() }
    
    // MARK: - API Methods
    private func getShows() {
        dispatchQueue.async { self.stateView = .loading }
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let result = try await repository.getShowsBy(page: page)
                self.shows.append(contentsOf: result)
                self.stateView = .content
            } catch {
                stateView = .error
            }
        }
    }
    
    private func getShow(for query: String) {
        Task { @MainActor [weak self] in
            guard let self else { return }
            do {
                let result = try await repository.getShowsFor(query: query)
                filteredShows = result.compactMap { $0.show }
                stateView = .content
                showEmptyStateVisibleForFilter = filteredShows.isEmpty
            } catch {
                stateView = .error
            }
        }
    }
    
    private func resetState() {
        page = .zero
        searchInput = ""
        filteredShows = []
        getShows()
    }
}
