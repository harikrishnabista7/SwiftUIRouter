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
            content(router.root)
                .navigationDestination(for: R.self) { route in
                    content(route)
                }
                .fullScreenCover(item: $router.coverRoute,
                                 onDismiss: router.onDismiss) { route in
                    content(route)
                }
                .sheet(item: $router.sheetRoute,
                       onDismiss: router.onDismiss) { route in
                    content(route)
                }
        }
    }
}
