//
//  SwiftUIRouterDemoApp.swift
//  SwiftUIRouterDemo
//
//  Created by HariKrishnaBista on 05/12/23.
//

import SwiftUI

@main
struct SwiftUIRouterDemoApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeCoordinator()
                    .tag(0)
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                SettingsCoordinator()
                    .tag(1)
                    .tabItem {
                        Label("Settings", systemImage: "gear")
                    }
            }
        }
    }
}
