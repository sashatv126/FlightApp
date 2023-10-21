//
//  SceneDelegate.swift
//  FlightApp
//
//  Created by Александр Александрович on 21.10.2023.
//

import SwiftUI
import Coordinator

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    private let coordinatorFactory = CoordinatorFactory()

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let homeCoordinator = coordinatorFactory.createHomeCoordinator()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = homeCoordinator.navigationController
        window?.makeKeyAndVisible()
        homeCoordinator.start()
    }
}
