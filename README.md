# SwiftUIRouter

  
SwiftUIRouter provides declarative navigation and presentation flows in a coordinator. It is a based on the iOS 16 navigation stack.
 It supports all types of complex routing like presenting multiple views, pushing from the presented views using single router instance.
 
It automatically manages the routing path for its root and child views which makes the usage so simple and doesn't require to maintain several navigation stacks.

**Usage**

``` Swift
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
```

