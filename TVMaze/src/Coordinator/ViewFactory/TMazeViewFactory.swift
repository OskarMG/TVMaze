//
//  TVMazeViewFactory.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import SwiftUI

public final class TMazeViewFactory {
    
    public init() {}
    
    public func makeDashboard(in coordinator: (any MainCoordinatable)?) -> some View {
        let viewModel = DashboardViewModel(coordinator: coordinator)
        return DashboardView(viewModel: viewModel)
    }
    
    public func makeTvShowDetails(_ tvShow: TVShow, in coordinator: (any MainCoordinatable)?) -> some View {
        debugPrint("tvShow", tvShow)
        return EmptyView()
    }
}
