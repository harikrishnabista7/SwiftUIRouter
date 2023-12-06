//
//  Route.swift
//
//
//  Created by HariKrishnaBista on 05/12/23.
//

import Foundation

/// Protocol to represent the view or screen to be shown by the router
public protocol Route: Hashable, Identifiable {}

public extension Identifiable where Self: Route {
    var id: Self { self }
}
