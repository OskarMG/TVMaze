//
//  NavigationCoordinator.swift
//  Navigation
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import SwiftUI

struct NavigationCoordinator<SomeCoordinator: Coordinatable>: View {
    private var coordinator: SomeCoordinator

    init(coordinator: SomeCoordinator) {
        self.coordinator = coordinator
    }

    var body: some View {
        coordinator.destination(for: coordinator.root)
            .navigationDestination(for: SomeCoordinator.Route.self) { destination in
                coordinator.destination(for: destination)
            }
            .onAppear {
                RouterRegistry.shared.router(for: coordinator).checkIsRouteEquivalenceNecessary(path: coordinator.root)
            }
    }
}
