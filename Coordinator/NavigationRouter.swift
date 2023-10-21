//
//  NavigationRouter.swift
//  Coordinator
//
//  Created by Александр Александрович on 21.10.2023.
//

import SwiftUI

public protocol NavigationRouter {
    associatedtype Routes
    associatedtype V: View
    var route: Routes { get set }
    var transition: NavigationTranisitionStyle { get }

    @ViewBuilder
    func view() -> V
}
