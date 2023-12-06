# SwiftUIRouter

Coordinator pattern in SwiftUI

SwiftUIRouter supports new navigation stack supporting from iOS version 16. 
It is inspired from another swiftUI navigation library called Flowstacks which is based on deprecated NavigationView. 

SwiftUIRouter provides declarative navigation and presentation flows in a coordinator.
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

**Methods**

| Method       | Effect                                            |
|--------------|---------------------------------------------------|
| push         | Pushes a new screen onto the stack.               |
| presentSheet | Presents a new screen as a sheet.  †                |
| presentCover | Presents a new screen as a full-screen cover.†    |
| popToRoot    | Goes back to the very first screen in the stack.  |
| popToRoute   | Goes back to a specific screen if found first in the stack starting from back.     |
| pop          | Pops the current screen if it was pushed.         |
| dismiss      | Dismisses the most recently presented screen.     |
| dismissToRoot| Dismisses all the presented screen and goes back to the root stack of presenting screen.               |

Note: if you want to be able to push screens from the presented screen. Provide withNavigation true in presentSheet and presentCover method
