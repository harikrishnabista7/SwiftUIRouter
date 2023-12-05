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
public class Router<R: Route>: ObservableObject {
    /// Root of the stack
    let root: R

    /// All route pushed in the stack
    @Published var routePath: [R] = []

    /// route to present as cover
    @Published var coverRoute: R?

    /// route to present as sheet
    @Published var sheetRoute: R?

    /// onDismiss closure for cover and sheet presentation
    private(set) var onDismiss: (() -> Void)?

    /// Initializes router to show root view at launch
    ///
    /// - Parameters:
    ///   - root: The view to display when the no other view is pushed or presented.
    public init(root: R) {
        self.root = root
    }

    /// Pushes route to the navigation stack maintained by the router
    ///
    /// - Parameters:
    ///   - route: The view to be pushed with default navigation back button represented by the route.
    public func push(_ route: R) {
        routePath.push(route)
    }

    /// Removes the current showing view and shows the previous screen from the navigation stack.
    public func pop() {
        routePath.pop()
    }

    /// Removes all the pushed views and shows the root view.
    public func popToRoot() {
        routePath.popToRoot()
    }

    /// Shows the  view represented by route by removing all other views after the route in the navigation stack.
    ///
    /// - Parameters:
    ///   - route: The view to be shown from all the pushed views
    public func popToRoute(_ route: R) {
        routePath.popTo(route)
    }

    /// Present full screen cover represented by route
    ///
    /// - Parameters:
    ///   - route: The view to be presented over the app.
    public func presentCover(_ route: R, onDismiss: (() -> Void)? = nil) {
        self.onDismiss = onDismiss
        coverRoute = route
    }

    /// Present sheet represented by route
    ///
    /// - Parameters:
    ///   - route: The view to be presented as sheet style over the app.
    public func presentSheet(_ route: R, onDismiss: (() -> Void)? = nil) {
        self.onDismiss = onDismiss
        sheetRoute = route
    }

    /// Dismiss any presented screen
    public func dismiss() {
        coverRoute = nil
        sheetRoute = nil
    }
}
