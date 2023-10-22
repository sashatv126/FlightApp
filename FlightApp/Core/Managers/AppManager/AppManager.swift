//
//  AppManager.swift
//  FlightApp
//
//  Created by Александр Александрович on 22.10.2023.
//

import TokenManager

protocol AppManagerProtocol {
    func updateAcesstoken()
}

final class AppManager {
    let tokenManager: APITokenManagerProtocol

    init(tokenManager: APITokenManagerProtocol) {
        self.tokenManager = tokenManager
    }

    func updateAcesstoken() {
        tokenManager.getAndSaveAccessTokenIfNeeded()
    }
}
