//
//  AppManager.swift
//  FlightApp
//
//  Created by Александр Александрович on 22.10.2023.
//

import TokenManager
import Combine

protocol AppManagerProtocol {
    func updateAcesstoken(completion: @escaping () -> ())
}

final class AppManager: AppManagerProtocol {
    private let tokenManager: APITokenManagerProtocol
    private var cancellable = Set<AnyCancellable>()

    init(tokenManager: APITokenManagerProtocol) {
        self.tokenManager = tokenManager
    }

    @MainActor func updateAcesstoken(completion: @escaping () -> ()) {
        Task {
            await tokenManager.getAndSaveAccessTokenIfNeeded()
            completion()
        }
    }
}
