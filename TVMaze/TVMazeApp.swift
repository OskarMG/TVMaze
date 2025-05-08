//
//  TVMazeApp.swift
//  TVMaze
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import SwiftUI

@main
struct TVMazeApp: App {
    private let factory = TMazeViewFactory()
    
    var body: some Scene {
        WindowGroup {
            RootNavigationCoordinator(root: MainCoordinator(factory))
        }
    }
}
