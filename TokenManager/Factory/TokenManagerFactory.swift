//
//  TokenManagerFactory.swift
//  TokenManager
//
//  Created by Александр Александрович on 22.10.2023.
//

import NetworkService
import KeychainManager

public protocol TokenManagerFactoryProtocol {
    func createTokenManager() -> APITokenManagerProtocol
}

final public class TokenManagerFactory {
    private let networkProvider: NetworkProviderProtocol

    public init(networkProvider: NetworkProviderProtocol) {
        self.networkProvider = networkProvider
    }
}

extension TokenManagerFactory: TokenManagerFactoryProtocol {
    public func createTokenManager() -> APITokenManagerProtocol {
        let keychain = KeychainManager<TokenManagerKey>()
        let tokenNetworkProvider = TokenNetworkProvider(networkProvider: networkProvider)
        return APITokenManager<KeychainManager<TokenManagerKey>>(keychain: keychain,
                                                                 networkProvider: tokenNetworkProvider)
    }
}
