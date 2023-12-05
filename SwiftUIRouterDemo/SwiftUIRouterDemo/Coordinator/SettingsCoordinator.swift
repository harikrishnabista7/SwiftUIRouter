//
//  SettingsCoordinator.swift
//  SwiftUIRouterDemo
//
//  Created by HariKrishnaBista on 05/12/23.
//

import SwiftUI
import SwiftUIRouter

enum SettingsCoordinatorRoute: Route {
    var id: Self { self }

    case settings, editProfile
}

struct SettingsCoordinator: View {
    @State private var router: Router<SettingsCoordinatorRoute> = .init(root: .settings)

    var body: some View {
        RoutingView(router: router) { route in
            switch route {
            case .settings:
                SettingsScreen {
                    router.presentCover(.editProfile)
                }
            case .editProfile:
                EditProfileScreen {
                    router.dismiss()
                }
            }
        }
    }
}
