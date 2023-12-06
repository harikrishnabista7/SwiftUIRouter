//
//  Router.swift
//
//
//  Created by HariKrishnaBista on 05/12/23.
//

import Foundation

/**
  A class that wraps the SwiftUI navigation stack logic for easy usages.
  This class provides UIKit like routing methods like push, pop, popToRoot, present etc

  Usage:
  ```swift
 Router(root: Route)
 **/
public final class Router<R: Route>: ObservableObject {
    /// Root of the stack
    let root: R

    /// All route pushed in the stack
    @Published var routePath: [R] = []

    /// route to present as cover
    @Published var coverRoute: R?

    /// route to present as sheet
    @Published var sheetRoute: R?

    @Published var presentingRoute: R?

    /// router that holds the presentRoute withNavigation
    @Published private(set) var subRouter: Router<R>?

    /// onDismiss closure for cover and sheet presentation
    private(set) var onDismiss: (() -> Void)?

    /// route presented over as fullscreen or sheet
    private var presentedRoute: R? { coverRoute ?? sheetRoute }

    /// boolean to indicate if any route is current presented over
    var hasPresentedRoute: Bool { presentedRoute != nil }

    /// Initializes router to show root view at launch
    ///
    /// - Parameters:
    ///   - root: The view to display when the no other view is pushed or presented.
    public init(root: R) {
        self.root = root
    }

    /// Clean up router after swipe dismiss
    /// - Returns: Handler
    func dismissHandler() -> () -> Void {
        return { [weak self] in
            self?.dismiss()
            self?.onDismiss?()
        }
    }

    /// Helper method to get current router to be used for push, pop events
    /// - Returns: Router
    private func getRouter() -> Router<R> {
        var router: Router<R> = self
        if let subRouter {
            router = subRouter.getRouter()
        }
        return router
    }

    private func findLastRouter(with route: R) -> Router<R>? {
        if routePath.contains(route) || root == route {
            return subRouter?.findLastRouter(with: route) ?? self
        } else if let subRouter {
            return subRouter.findLastRouter(with: route)
        }
        return nil
    }

    /// Pushes route to the navigation stack maintained by the router
    ///
    /// - Parameters:
    ///   - route: The view to be pushed with default navigation back button represented by the route.
    public func push(_ route: R) {
        if let presentedRoute = presentedRoute, subRouter == nil {
            let errorMessage = "Presented route \(presentedRoute) with no navigation cannot push route \(route). This will dismiss the presented route before pushing route \(route). You can use withNavigation: true when presenting the route \(presentedRoute)"
            debugPrint(errorMessage)
            dismissToRoot()
        }
        let router = getRouter()
        router.routePath.push(route)
    }

    /// Removes the current showing view and shows the previous screen from the navigation stack.
    public func pop() {
        let router = getRouter()
        if !router.routePath.isEmpty {
            router.routePath.pop()
        }
    }

    /// Removes all the pushed views and shows the root view.
    public func popToRoot() {
        dismissToRoot()
        routePath.popToRoot()
    }

    /// Shows the  view represented by route by removing all other views after the route in the navigation stack.
    ///
    /// - Parameters:
    ///   - route: The view to be shown from all the pushed views
    public func popToRoute(_ route: R) {
        guard let router = findLastRouter(with: route) else { return }
        router.dismiss()
        let success = router.routePath.popTo(route)
        if !success && router.root == route {
            router.popToRoot()
        }
    }

    /// Present full screen cover represented by route
    ///
    /// - Parameters:
    ///   - route: The view to be presented over the app.
    public func presentCover(_ route: R, withNavigation: Bool = false, onDismiss: (() -> Void)? = nil) {
        if let subRouter {
            subRouter.presentCover(route, withNavigation: withNavigation, onDismiss: onDismiss)
        } else {
            self.onDismiss = onDismiss
            coverRoute = route
            subRouter = withNavigation ? Router(root: route) : nil
        }
    }

    /// Present sheet represented by route
    ///
    /// - Parameters:
    ///   - route: The view to be presented as sheet style over the app.
    public func presentSheet(_ route: R, withNavigation: Bool = false, onDismiss: (() -> Void)? = nil) {
        if let subRouter {
            subRouter.presentSheet(route, withNavigation: withNavigation, onDismiss: onDismiss)
        } else {
            self.onDismiss = onDismiss
            sheetRoute = route
            subRouter = withNavigation ? Router(root: route) : nil
        }
    }

    /// Dismiss any presented screen
    public func dismiss() {
        if let subRouter = subRouter, subRouter.hasPresentedRoute {
            subRouter.dismiss()
        } else {
            dismissToRoot()
        }
    }

    /// Dismisses all the presented routes and shows root navigation
    public func dismissToRoot() {
        subRouter = nil
        coverRoute = nil
        sheetRoute = nil
    }
}
