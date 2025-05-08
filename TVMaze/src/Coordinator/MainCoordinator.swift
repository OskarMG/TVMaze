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
        }
    }
}

extension MainCoordinator {
    func makeDashboard() -> some View {
        factory.makeDashboard(in: self)
    }
}
