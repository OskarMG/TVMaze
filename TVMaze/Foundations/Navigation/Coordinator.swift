//
//  Coordinator.swift
//  Navigation
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TMaze Demo. All rights reserved.
//

import SwiftUI

public protocol Coordinatable: AnyObject, HashableByType {
    associatedtype Destination: View
    associatedtype Route: Routable

    var root: Route { get set }

    @MainActor
    @ViewBuilder
    func destination(for route: Route) -> Destination
}

// swiftlint: disable identifier_name
public extension Coordinatable {
    /// Default router instance for navigation management.
    fileprivate var router: Router {
        RouterRegistry.shared.router(for: self)
    }

    /// Removes the associated router for the current coordinator from the `RouterRegistry`.
    ///
    /// This method should be called when the coordinator is no longer needed to ensure proper
    /// cleanup and avoid memory leaks.
    ///
    /// - Important: After calling this method, any attempt to use the router associated with
    ///   this coordinator will result in the creation of a new router.
    ///
    /// - Usage:
    ///   Call this method inside `deinit` or when the navigation flow for the coordinator ends.
    ///
    /// - Example:
    ///   ```swift
    ///   deinit {
    ///       destroyRouter()
    ///   }
    ///   ```
    func destroyRouter() {
        RouterRegistry.shared.removeRouter(for: self)
    }

    /// Push to a specific destination.
    ///
    /// Pushes a new view onto the navigation stack, directing the app to the specified route.
    ///
    /// - Parameter to: The `Route` to navigate to, handled by the router.
    func push(to: Route) {
        router.push(to: to)
    }

    /// Push to the specified destination or pops the view if it already exists in the navigation stack.
    ///
    /// Checks if the specified route (`to`) is already in the navigation stack. If it exists, this method
    /// navigates back to it by popping views. If it doesn't exist, it pushes the route as a new destination.
    ///
    /// - Parameter to: The destination `Route` to navigate to or pop back to if it already exists.
    func pushOrPop(to: Route) {
        router.pushOrPop(to: to)
    }

    /// Pops the last view from the navigation stack.
    ///
    /// This method navigates back by one step in the navigation stack, using the router to handle the action.
    func pop() {
        router.pop()
    }

    /// Pops the navigation stack to a specific view.
    ///
    /// Removes views from the stack until reaching the specified target view.
    ///
    /// - Parameter to: The target view to pop to, identified by a unique `Routable` conforming type.
    func pop(to: Route) {
        router.pop(to: to)
    }

    /// Pops all views from the navigation stack, returning to the root of the coordinator.
    ///
    /// Clears the navigation stack back to the coordinator’s root view.
    func popToRootOfCoordinator() {
        router.pop(to: self.root)
    }

    /// Pops all views from the navigation stack, returning to the root view.
    ///
    /// Navigates back to the root view, clearing all views in between.
    func popToRoot() {
        router.popToRoot()
    }

    /// Presents a specified view with a given presentation style.
    ///
    /// Displays a new view as a modal sheet or fullscreen, depending on the `PresentationType`.
    ///
    /// - Parameters:
    ///   - view: The destination `Route` to present as a modal view.
    ///   - type: The `PresentationType` that specifies how the view should be presented (e.g., as a sheet or fullscreen).
    ///
    /// - Example:
    ///   ```swift
    ///   present(.detailView, type: .sheet(detents: [.medium, .large]))
    ///   ```
    @MainActor
    func present(_ view: Route, type: PresentationType) {
        let view = AnyView(destination(for: view))
        router.present(view: view, type: type)
    }

    /// Dismisses the current coordinator view.
    ///
    /// Calls the router’s `dismiss` method, dismissing the coordinator’s root view.
    func dismiss() {
        router.dismiss(firstCoordinatorView: self.root)
    }

    /// Sets a new root view for the navigation stack.
    ///
    /// Replaces the current root with the specified view, making it the new entry point in the stack.
    ///
    /// - Parameter newRoot: The view to set as the root.
    func root(_ newRoot: Route) {
        router.root(newRoot)
    }

    /// Replaces the entire navigation stack with a new set of views.
    ///
    /// Clears the current navigation stack and replaces it with the specified array of views.
    ///
    /// - Parameter newStack: An array of views conforming to `Routable`, which will replace the current stack.
    func replaceStack(_ newStack: [Route]) {
        router.replaceStack(newStack)
    }

    /// Starts the coordinator by embedding it in a `NavigationCoordinator` view.
    ///
    /// - Returns: A SwiftUI view wrapped in a `NavigationCoordinator`, which manages navigation for the coordinator.
    @MainActor
    @ViewBuilder
    func start() -> some View {
        NavigationCoordinator(coordinator: self)
    }
}
// swiftlint: enable identifier_name
