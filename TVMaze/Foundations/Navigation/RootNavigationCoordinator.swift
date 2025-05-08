//
//  RootNavigationCoordinator.swift
//  Navigation
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import SwiftUI

public struct RootNavigationCoordinator<SomeCoordinator: Coordinatable>: View {
    private var coordinator: SomeCoordinator
    @StateObject private var navigationManager: NavigationManager = NavigationManager<EmptyView>()

    public init(root: SomeCoordinator) {
        coordinator = root
    }

    public var body: some View {
        ZStack {
            NavigationStack(path: $navigationManager.navigationStack) {
                coordinator.destination(for: coordinator.root)
                    .navigationDestination(for: SomeCoordinator.Route.self) { destination in
                        coordinator.destination(for: destination)
                    }
                    .sheet(isPresented: navigationManager.isPresenting(with: .sheet())) {
                        let detents = navigationManager.presentedRoute?.type.detents
                        let dragIndicator = navigationManager.presentedRoute?.type.dragIndicator
                        viewToPresent
                            .presentationDetents(detents ?? .init())
                            .presentationDragIndicator(dragIndicator ?? .automatic)
                    }
                    .fullScreenCover(isPresented: navigationManager.isPresenting(with: .fullScreen)) {
                        viewToPresent
                    }
            }
            .onAppear {
                navigationManager.setUpAsDelegateForRouters()
            }
            if navigationManager.isPresenting(with: .sheet()).wrappedValue {
                Color.black.opacity(.opacity)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.easeInOut(duration: .easeInOutDuration), value: navigationManager.isPresenting(with: .sheet()).wrappedValue)
            }
        }
    }

    @ViewBuilder
    private var viewToPresent: some View {
        if let route = navigationManager.presentedRoute?.view {
            route
        } else {
            EmptyView()
        }
    }
}

private extension Double {
    static let opacity: Double = 0.6
    static let easeInOutDuration: Double = 0.3
}
