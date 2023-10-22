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

@MainActor final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    private let coordinatorFactory: CoordinatorFactory = {
        let managerFactory = ManagerFactory()
        return CoordinatorFactory(managerFactory: managerFactory)
    }()
    
    private var appManager: AppManagerProtocol?
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let homeCoordinator = coordinatorFactory.createHomeCoordinator()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let networkService = NetworkService()
        let networkProvider = NetworkProvider(networkService: networkService)
        let tokenManagerFactory = TokenManagerFactory(networkProvider: networkProvider)
        let tokenManager = tokenManagerFactory.createTokenManager()
        let appManager = AppManager(tokenManager: tokenManager)
        self.appManager = appManager
        appManager.updateAcesstoken { [weak self] in
            self?.window = UIWindow(windowScene: windowScene)
            self?.window?.rootViewController = homeCoordinator.navigationController
            self?.window?.makeKeyAndVisible()
            homeCoordinator.start()
        }
    }
}
