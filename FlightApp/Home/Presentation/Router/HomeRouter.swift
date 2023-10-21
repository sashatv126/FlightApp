//
//  HomeRouter.swift
//  FlightApp
//
//  Created by Александр Александрович on 21.10.2023.
//

import SwiftUI
import Coordinator

struct HomeRouter: NavigationRouter {

    enum Routes {
        case home
        case detail
    }

    var route: Routes = .home

    private let viewFactory: HomeViewFactoryProtocol

    init(viewFactory: HomeViewFactoryProtocol) {
        self.viewFactory = viewFactory
    }

    public var transition: NavigationTranisitionStyle {
        switch route {
        case .detail:
            return .push
        case .home:
            return .push
        }
    }

    @MainActor @ViewBuilder
    public func view() -> some View {
        switch route {
        case .detail:
            EmptyView()
        case .home:
            viewFactory.makeHomeView()
        }
    }
}

