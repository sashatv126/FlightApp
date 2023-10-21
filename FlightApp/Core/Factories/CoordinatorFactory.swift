//
//  CoordinatorFactory.swift
//  FlightApp
//
//  Created by Александр Александрович on 21.10.2023.
//

import UIKit
import Coordinator

protocol CoordinatorFactoryProtocol {
    func createHomeCoordinator(navigationController: UINavigationController) -> Coordinator<HomeRouter>
}

final class CoordinatorFactory {}

extension CoordinatorFactory: CoordinatorFactoryProtocol {
    func createHomeCoordinator(navigationController: UINavigationController = .init() ) -> Coordinator<HomeRouter> {
        let viewFactory = HomeViewFactory()
        return Coordinator(navigationController: navigationController,
                           startingRouter: .init(viewFactory: viewFactory))
    }
}
