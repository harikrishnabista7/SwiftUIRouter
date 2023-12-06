//
//  File.swift
//
//
//  Created by HariKrishnaBista on 05/12/23.
//

import SwiftUI

/**
  A SwiftUI view that integrates with a `Router` to manage navigation through different routes.

  Usage:
  ```swift
 RoutingView(router: myRouter) { route in
      // Content view for the specified route
  }
 **/
public struct RoutingView<R: Route, Content: View>: View {
    public init(router: Router<R>, @ViewBuilder content: @escaping (R) -> Content) {
        _router = StateObject(wrappedValue: router)
        self.content = content
    }

    /// router that manages the routing path for navigation stack
    @StateObject var router: Router<R>

    /// View or screen for specified route
    @ViewBuilder let content: (R) -> Content

    public var body: some View {
        NavigationStack(path: $router.routePath) {
            getContent(for: router.root, canPresent: router.routePath.isEmpty)
                .navigationDestination(for: R.self) { route in
                    getContent(for: route, canPresent: router.routePath.last == route)
                }
        }
    }

    @ViewBuilder
    private func getContent(for route: R, canPresent: Bool) -> some View {
        if canPresent {
            content(route)
                .fullScreenCover(item: $router.coverRoute,
                                 onDismiss: router.onDismiss) { route in
                    getContentForPresented(route: route)
                }
                .sheet(item: $router.sheetRoute,
                       onDismiss: router.onDismiss) { route in
                    getContentForPresented(route: route)
                }

        } else {
            content(route)
        }
    }

    @ViewBuilder
    private func getContentForPresented(route: R) -> some View {
        if let subRouter = router.subRouter {
            RoutingView(router: subRouter) { route in
                content(route)
            }
        } else {
            content(route)
        }
    }
}
