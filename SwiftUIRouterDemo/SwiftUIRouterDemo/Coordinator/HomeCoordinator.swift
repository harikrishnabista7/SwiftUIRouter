//
//  HomeCoordinator.swift
//  SwiftUIRouterDemo
//
//  Created by HariKrishnaBista on 05/12/23.
//
import SwiftUI
import SwiftUIRouter

enum HomeCoordinatorRoute: Route {
    var id: Self { self }
    
    case home, detail
}

struct HomeCoordinator: View {
    @State private var router: Router<HomeCoordinatorRoute> = .init(root: .home)

    var body: some View {
        RoutingView(router: router) { route in
            switch route {
            case .home:
                HomeScreen(goToDetail: showDetail)
            case .detail:
                HomeDetailScreen(goBack: goBack)
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
