//
//  MainCoordinator.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import SwiftUI

public enum MainRoute: Routable {
    case dashboard
    case tvShowDetail(TVShow)
    case episodeDetail(Episode)
}

public final class MainCoordinator: MainCoordinatable {
    /// `Properties`
    private let factory: TMazeViewFactory
    public var root: MainRoute = .dashboard

    init(_ factory: TMazeViewFactory) {
        self.factory = factory
    }

    deinit {
        destroyRouter()
    }

    public func destination(for route: MainRoute) -> some View {
        switch route {
        case .dashboard:
            makeDashboard()
        case let .tvShowDetail(tvShow):
            makeTvShowDetails(tvShow)
        case let .episodeDetail(episode):
            makeEpisodeDetails(episode)
        }
    }
    
    /// `Navigation` methods
    public func didTapOnTvShow(_ tvShow: TVShow){
        push(to: .tvShowDetail(tvShow))
    }
    
    public func didTapOn(_ episode: Episode) {
        Task { @MainActor in
            present(
                .episodeDetail(episode),
                type: .sheet(detents: [.medium], dragIndicator: .hidden)
            )
        }
    }
}

extension MainCoordinator {
    func makeDashboard() -> some View {
        factory.makeDashboard(in: self)
    }
    
    func makeTvShowDetails(_ tvShow: TVShow) -> some View {
        factory.makeTvShowDetails(tvShow, in: self)
    }
    
    func makeEpisodeDetails(_ episode: Episode) -> some View {
        factory.makeEpisodeDetails(episode)
    }
}
