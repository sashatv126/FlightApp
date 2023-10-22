//
//  SceneDelegate.swift
//  FlightApp
//
//  Created by Александр Александрович on 21.10.2023.
//

import SwiftUI
import Coordinator
import TokenManager
import KeychainManager
import NetworkService

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    private let coordinatorFactory: CoordinatorFactory = {
        let managerFactory = ManagerFactory()
        return CoordinatorFactory(managerFactory: managerFactory)
    }()

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let homeCoordinator = coordinatorFactory.createHomeCoordinator()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let networkService = NetworkService()
        let networkProvider = NetworkProvider(networkService: networkService)
        let tokenManagerFactory = TokenManagerFactory(networkProvider: networkProvider)
        let tokenManager = tokenManagerFactory.createTokenManager()
        let appManager = AppManager(tokenManager: tokenManager)
        appManager.updateAcesstoken()
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = homeCoordinator.navigationController
        window?.makeKeyAndVisible()
        homeCoordinator.start()
    }
}
