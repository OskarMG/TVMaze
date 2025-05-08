//
//  NavigationManager.swift
//  Navigation
//
//  Created by Oscar Martínez Germán on 8/5/25.
//  Copyright © 2025 TVMaze Demo. All rights reserved.
//

import Combine
import SwiftUI

// swiftlint: disable all
/// Protocol defining core navigation actions for a custom router.
///
/// `RouterDelegate` defines navigation functions, including push, pop, dismiss, and root actions,
/// allowing implementations to manage complex navigation flows and control specific routing behavior.
private protocol RouterDelegate: AnyObject {
    /// Pushes a new view to the navigation stack.
    /// - Parameter to: A unique identifier conforming to `Routable` representing the destination.
    func push(to: any Routable)

    /// Navigates to the specified route or returns to it if it's already present in the navigation stack.
    ///
    /// This method attempts to push the specified route onto the navigation stack if it doesn't already exist
    /// in the current stack. If the route is found in the stack, it instead performs a pop operation,
    /// bringing the user back to the route's view.
    ///
    /// - Parameter to: The destination route, conforming to `Routable`, to either push or pop to in the navigation stack
    func pushOrPop(to: any Routable)

    /// Pops the last view from the navigation stack.
    func pop()

    /// Pops the navigation stack to a specified view, removing intermediate views.
    /// - Parameter to: The view to pop to, identified by a `Routable` identifier.
    func pop(to: any Routable)

    /// Pops all views from the navigation stack, returning to the root view.
    func popToRoot()

    func present(view: AnyView, type: PresentationType)

    /// Dismisses a specified view, then pops the stack by an additional level.
    /// - Parameter firstCoordinatorView: The first view to dismiss, specified by `Routable`.
    func dismiss(firstCoordinatorView: any Routable)

    /// Sets a new root view in the navigation stack.
    /// - Parameter newRoot: The view to set as the root, specified by `Routable`.
    func root(_ newRoot: any Routable)

    /// Replaces the current navigation stack with a new stack of views.
    ///
    /// This function clears both `navigationStack` and `navigationHistory`, then repopulates
    /// them with the views provided in `newStack`.
    ///
    /// - Parameter newStack: An array of views conforming to `Routable` that will replace the current navigation stack.
    func replaceStack(_ newStack: [any Routable])

    /// Checks and sets route equivalence if necessary for a given path.
    /// - Parameter path: The path to be checked for equivalence.
    func checkIsRouteEquivalenceNecessary(path: any Routable)
}

/// A registry that manages and provides unique `Router` instances for each `Coordinatable`.
///
/// `RouterRegistry` ensures that each coordinator has a dedicated `Router` instance,
/// avoiding conflicts across multiple navigation flows. It follows a singleton pattern
/// to centralize router management, and provides lifecycle methods to associate or
/// clean up routers when needed.
final class RouterRegistry {

    /// Shared singleton instance of the `RouterRegistry`.
    ///
    /// Use this to access or register routers globally across the app.
    nonisolated(unsafe) static let shared = RouterRegistry()

    /// A weak reference to the navigation delegate that handles routing actions.
    ///
    /// This delegate is injected into each router to handle navigation commands.
    private weak var delegate: RouterDelegate?

    /// A dictionary mapping each coordinator to its corresponding router instance.
    ///
    /// The key is the `ObjectIdentifier` of the coordinator, ensuring uniqueness.
    private var routers: [ObjectIdentifier: Router] = [:]

    /// Private initializer to enforce singleton usage.
    ///
    /// Use `RouterRegistry.shared` instead.
    private init() {}

    // MARK: - Public Methods

    /// Returns a unique `Router` for the given `Coordinatable` instance.
    ///
    /// If a router already exists for the coordinator, it is returned. Otherwise,
    /// a new router is created, stored, and returned.
    ///
    /// - Parameter coordinator: The coordinator requesting the router.
    /// - Returns: The associated `Router` instance.
    ///
    /// - Example:
    ///   ```swift
    ///   let router = RouterRegistry.shared.router(for: myCoordinator)
    ///   ```
    func router(for coordinator: any Coordinatable) -> Router {
        let key = ObjectIdentifier(coordinator)

        if let existingRouter = routers[key] {
            return existingRouter
        }

        let newRouter = Router()
        newRouter.delegate = delegate
        routers[key] = newRouter
        return newRouter
    }

    /// Removes the router associated with the given coordinator.
    ///
    /// This should be called when a coordinator is no longer needed, to avoid memory leaks.
    ///
    /// - Parameter coordinator: The coordinator whose router should be removed.
    ///
    /// - Important: Always remove routers when a flow ends or a coordinator is deallocated.
    ///
    /// - Example:
    ///   ```swift
    ///   RouterRegistry.shared.removeRouter(for: myCoordinator)
    ///   ```
    func removeRouter(for coordinator: any Coordinatable) {
        let key = ObjectIdentifier(coordinator)
        routers.removeValue(forKey: key)
    }

    // MARK: - Internal Usage

    /// Registers a `RouterDelegate` and assigns it to all existing routers.
    ///
    /// - Parameter delegate: The delegate to be used by all routers.
    ///
    /// This is used internally to propagate the delegate to previously created routers.
    fileprivate func registerDelegateForRoutes(delegate: RouterDelegate) {
        self.delegate = delegate
        for (_, router) in routers {
            router.delegate = self.delegate
        }
    }
}

// MARK: Router
/// Singleton class managing navigation actions for the app.
///
/// `Router` provides a central interface for navigation actions, delegating
/// to an object conforming to `RouterDelegate`.
final class Router {
    /// A weak reference to the navigation delegate that executes the actions.
    fileprivate weak var delegate: RouterDelegate?

    init() {}

    /// Pushes a new view to the navigation stack.
    /// - Parameter to: The destination view identified by `Routable`.
    func push(to: any Routable) {
        delegate?.push(to: to)
    }

    /// Navigates to the specified route or returns to it if it's already present in the navigation stack.
    ///
    /// This method attempts to push the specified route onto the navigation stack if it doesn't already exist
    /// in the current stack. If the route is found in the stack, it instead performs a pop operation,
    /// bringing the user back to the route's view.
    ///
    /// - Parameter to: The destination route, conforming to `Routable`, to either push or pop to in the navigation stack
    func pushOrPop(to: any Routable) {
        delegate?.pushOrPop(to: to)
    }

    /// Pops the last view from the navigation stack.
    func pop() {
        delegate?.pop()
    }

    /// Pops the stack to a specific view.
    /// - Parameter to: The target view to pop to, identified by `Routable`.
    func pop(to: any Routable) {
        delegate?.pop(to: to)
    }

    /// Pops all views from the navigation stack, returning to the root view.
    func popToRoot() {
        delegate?.popToRoot()
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
    func present(view: AnyView, type: PresentationType) {
        delegate?.present(view: view, type: type)
    }

    /// Dismisses the actual coordinator.
    /// - Parameter firstCoordinatorView: The first view of coordinator to be dismissed.
    func dismiss(firstCoordinatorView: any Routable) {
        delegate?.dismiss(firstCoordinatorView: firstCoordinatorView)
    }

    /// Sets a new root view for the navigation stack.
    /// - Parameter newRoot: The new root view.
    func root(_ newRoot: any Routable) {
        delegate?.root(newRoot)
    }

    /// Replaces the current navigation stack with a new stack of views.
    ///
    /// This function clears both `navigationStack` and `navigationHistory`, then repopulates
    /// them with the views provided in `newStack`.
    ///
    /// - Parameter newStack: An array of views conforming to `Routable` that will replace the current navigation stack.
    func replaceStack(_ newStack: [any Routable]) {
        delegate?.replaceStack(newStack)
    }

    /// Checks if a route equivalence is necessary for a specific path.
    /// - Parameter path: The path to check for equivalence.
    func checkIsRouteEquivalenceNecessary(path: any Routable) {
        delegate?.checkIsRouteEquivalenceNecessary(path: path)
    }
}

// MARK: NavigationManager
/// Manages navigation stack and history, handling routing and navigation actions for `Router`.
///
/// `NavigationManager` maintains the navigation stack and provides custom navigation handling,
/// including native back gestures and route equivalence mapping.
final class NavigationManager<PresentView: View>: ObservableObject {
    /// Published navigation path for SwiftUI's `NavigationPath`.
    @Published var navigationStack = NavigationPath()
    @Published var presentedRoute: (view: AnyView, type: PresentationType)?

    /// Tracks the navigation history with `HashableByType` route identifiers.
    private var navigationHistory: [any Routable] = []

    /// Stores equivalences between routes for simplified route matching.
    private var routeEquivalences: [String: String] = [:]

    /// Stores cancellable subscriptions for managing memory.
    private var cancellables = Set<AnyCancellable>()

    /// Initializes `NavigationManager` and configures router delegate and back-navigation subscriptions.
    init() {
        suscribeToNavigationPath()
    }

    /// Monitors changes in `navigationStack` to update `navigationHistory` on native back gestures.
    private func suscribeToNavigationPath() {
        $navigationStack.sink { [weak self] newValue in
            guard let self else { return }
            // Remove elements from `navigationHistory` when native back gesture is used.
            if navigationHistory.count > newValue.count {
                // Calculate elements to remove
                let elementsToRemove = navigationHistory.count - newValue.count
                // Identify routes for removal
                let routesToRemove: [String] = navigationHistory.suffix(elementsToRemove).map { $0.id }
                // Update navigation history and remove equivalences for these routes
                navigationHistory.removeLast(elementsToRemove)
                removeRouteEquivalence(routes: routesToRemove)
            }
        }
        .store(in: &cancellables)
    }

    /// Sets up this manager as the `RouterDelegate` to handle navigation actions.
    func setUpAsDelegateForRouters() {
        RouterRegistry.shared.registerDelegateForRoutes(delegate: self)
    }

    func isPresenting(with type: PresentationType) -> Binding<Bool> {
        Binding<Bool> { [weak self] in
            guard let currentType = self?.presentedRoute?.type else {
                return false
            }
            return currentType == type
        } set: { [weak self] newValue in
            guard let self, !newValue else { return }
            self.presentedRoute = nil
        }
    }
}

// MARK: NavigationManager - RouterDelegate
extension NavigationManager: RouterDelegate {
    /// Pushes a new route onto `navigationStack` and `navigationHistory`.
    func push(to: any Routable) {
        navigationHistory.append(to)
        navigationStack.append(to)
    }

    /// Routes to the specified destination or pops the view if it's already in the navigation stack.
    ///
    /// This function checks if the specified route (`to`) is already in the navigation stack. If the route
    /// exists, it navigates back to it by popping the necessary views. If the route is not present in
    /// the stack, it pushes the route as a new destination.
    ///
    /// - Parameter to: The destination `Route` to navigate to or pop back to if it already exists in the stack.
    func pushOrPop(to: any Routable) {
        let equivalence: String = getRouteEquivalence(forPath: to) ?? to.id
        guard isInStack(equivalence) else {
            push(to: to)
            return
        }
        pop(to: to)
    }

    /// Pops the last route from both `navigationStack` and `navigationHistory`.
    func pop() {
        guard presentedRoute != nil else {
            navigationHistory.removeLast()
            navigationStack.removeLast()
            return
        }
        presentedRoute = nil
    }

    /// Pops to a specific route, removing intermediate views.
    func pop(to: any Routable) {
        var id: String = to.id

        // Resolve route equivalences if available
        if let equivalentRoute = routeEquivalences.first(where: { $0.value == id }) {
            id = equivalentRoute.key
        }
        guard let index = navigationHistory.lastIndex(where: { $0.id == id }) else { return }
        let elementsToRemove = navigationHistory.count - (index + 1)
        guard elementsToRemove > .zero else { return }
        navigationStack.removeLast(elementsToRemove)
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
    func present(view: AnyView, type: PresentationType) {
        self.presentedRoute = (view, type)
    }

    /// Pops all views from the navigation stack, returning to the root view.
    func popToRoot() {
        guard let first = navigationHistory.first else { return }
        pop(to: first)
    }

    /// Dismisses a specified view and pops the stack.
    func dismiss(firstCoordinatorView: any Routable) {
        pop(to: firstCoordinatorView)
        pop()
    }

    /// Resets the navigation stack and sets a new root view.
    func root(_ newRoot: any Routable) {
        navigationStack = NavigationPath()
        navigationHistory = []
        navigationStack.append(newRoot)
    }

    /// Replaces the current navigation stack with a new stack of views.
    ///
    /// This function clears both `navigationStack` and `navigationHistory`, then repopulates
    /// them with the views provided in `newStack`.
    ///
    /// - Parameter newStack: An array of views conforming to `Routable` that will replace the current navigation stack.
    func replaceStack(_ newStack: [any Routable]) {
        // Clear current navigation history and stack
        navigationHistory.removeAll()
        navigationStack = NavigationPath()

        // Add each view in `newStack` to both navigation history and stack
        navigationHistory.append(contentsOf: newStack)
        newStack.forEach { route in
            navigationStack.append(route)
        }
    }

    /// Checks if route equivalence is necessary for a path and adds it if required.
    /// - Parameter path: The path to check for equivalence.
    func checkIsRouteEquivalenceNecessary(path: any Routable) {
        guard let lastRoute = navigationHistory.last, !routeEquivalences.values.contains(path.id), path.id != lastRoute.id else { return }
        addRouteEquivalence(toPath: lastRoute, forPath: path)
    }

    /// Adds a route equivalence for navigation matching.
    /// - Parameters:
    ///   - toPath: The original route path.
    ///   - forPath: The equivalent route path.
    private func addRouteEquivalence(toPath: any Routable, forPath: any Routable) {
        routeEquivalences[toPath.id] = forPath.id
    }

    /// Retrieves the equivalent route for a given `Routable` path, if it exists.
    ///
    /// This function checks if the given `Routable` path has a corresponding equivalent route in the
    /// `routeEquivalences` dictionary. It searches by both key and value to ensure comprehensive coverage.
    ///
    /// - Parameter forPath: The `Routable` path to look up in the equivalences.
    /// - Returns: An optional `Routable` containing the equivalent path, or `nil` if no equivalent route exists.
    private func getRouteEquivalence(forPath: any Routable) -> String? {
        let pathId: String = forPath.id

        // Check if there's an equivalence by key
        if let equivalentId = routeEquivalences[pathId],
           let equivalentRoute = routeEquivalences.first(where: { $0.value == equivalentId }) {
            return equivalentRoute.key // assuming `Routable` has an initializer from `String`
        }

        // Check if there's an equivalence by value
        if let equivalentRoute = routeEquivalences.first(where: { $0.value == pathId }) {
            return equivalentRoute.value // assuming `Routable` has an initializer from `String`
        }

        return nil // No equivalence found
    }

    /// Removes equivalences for specific routes.
    /// - Parameter routes: Array of route IDs to remove.
    private func removeRouteEquivalence(routes: [String]) {
        let routesToRemove = routeEquivalences.filter { routes.contains($0.key) }
        guard !routesToRemove.isEmpty else { return }
        routesToRemove.forEach { routeEquivalences.removeValue(forKey: $0.key) }
    }

    /// Checks if a specific route exists in `navigationHistory`.
    /// - Parameter route: The route to check for existence.
    /// - Returns: A Boolean indicating whether the route is present.
    private func isInStack(_ routeId: String) -> Bool {
        navigationHistory.contains { $0.id == routeId }
    }
}
// swiftlint: enable all
