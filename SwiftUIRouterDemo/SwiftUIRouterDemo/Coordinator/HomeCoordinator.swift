//
//  HomeCoordinator.swift
//  SwiftUIRouterDemo
//
//  Created by HariKrishnaBista on 05/12/23.
//
import SwiftUI
import SwiftUIRouter

enum HomeCoordinatorRoute: Route {
    case home, detail, presentWithNavigation, pushFromNavigation
}

struct HomeCoordinator: View {
    @State private var router: Router<HomeCoordinatorRoute> = .init(root: .home)

    var body: some View {
        RoutingView(router: router) { route in
            switch route {
            case .home:
                HomeScreen(goToDetail: showDetail) {
                    router.presentCover(.presentWithNavigation, withNavigation: true)
                }
            case .detail:
                HomeDetailScreen(goBack: goBack)
            case .presentWithNavigation:
                PresentedFromHome {
                    router.push(.pushFromNavigation)
                }
            case .pushFromNavigation:
                PushedFromPresented {
                    router.dismiss()
                }
            }
        }
    }

    private func showDetail() {
        router.push(.detail)
    }

    private func goBack() {
        router.pop()
    }
}
