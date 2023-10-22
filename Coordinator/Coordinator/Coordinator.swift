//
//  Coordinator.swift
//  Coordinator
//
//  Created by Александр Александрович on 21.10.2023.
//

import SwiftUI

open class Coordinator<Router: NavigationRouter>: ObservableObject {

    public let navigationController: UINavigationController
    public let startingRouter: Router?

    public init(navigationController: UINavigationController = .init(),
                startingRouter: Router? = nil) {
        self.navigationController = navigationController
        self.startingRouter = startingRouter
        navigationController.navigationBar.prefersLargeTitles = true
    }

    public func start() {
        guard let router = startingRouter else { return }
        show(route: router.route)
    }

    public func show(route: Router.Routes? = nil ,animated: Bool = true) {
        guard var router = startingRouter, let route else { return }
        router.route = route
        let view = router.view()
        let viewWithCoordinator = view.environmentObject(self)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        switch router.transition {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .presentModally:
            viewController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated)
        case .presentFullscreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
        }
    }

    public func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }

    public func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }

    open func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: true) { [weak self] in
            self?.navigationController.viewControllers = []
        }
    }
}
