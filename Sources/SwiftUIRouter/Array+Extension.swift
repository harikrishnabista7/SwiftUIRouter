//
//  File.swift
//
//
//  Created by HariKrishnaBista on 05/12/23.
//

import Foundation

/// Helper extension for Router
extension Array where Element: Route {
    mutating func push(_ route: Element) {
        append(route)
    }

    mutating func pop() {
        removeLast()
    }

    mutating func popTo(_ route: Element) -> Bool {
        if let index = firstIndex(of: route) {
            self = Array(self[0 ... index])
            return true
        }
        return false
    }

    mutating func popToRoot() {
        removeAll()
    }
}
