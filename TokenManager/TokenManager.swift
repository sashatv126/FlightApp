//
//  TokenManager.swift
//  TokenManager
//
//  Created by Александр Александрович on 22.10.2023.
//

import KeychainManager

public typealias AccessToken = String

public protocol APITokenManagerProtocol {
    func getAndSaveAccessTokenIfNeeded()
}

final public class APITokenManager<Keychain: KeychainManagerProtocol> where Keychain.Key == TokenManagerKey {

    private let keychain: Keychain
    private let networkProvider: TokenNetworkProviderProtocol

    init(keychain: Keychain,
                networkProvider: TokenNetworkProviderProtocol) {
        self.keychain = keychain
        self.networkProvider = networkProvider
    }
}

extension APITokenManager: APITokenManagerProtocol {
    public func getAndSaveAccessTokenIfNeeded() {
        Task { [weak self] in
            guard let result = await self?.networkProvider.fetchRequest() else { return }
            switch result {
            case .success(let token):
                try? self?.keychain.saveValue(value: token, by: .accessToken)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
