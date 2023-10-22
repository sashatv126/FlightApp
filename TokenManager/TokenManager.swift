//
//  TokenManager.swift
//  TokenManager
//
//  Created by Александр Александрович on 22.10.2023.
//

import KeychainManager
import Combine

public typealias AccessToken = String

public protocol APITokenManagerProtocol {
    func getAndSaveAccessTokenIfNeeded() async
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
    public func getAndSaveAccessTokenIfNeeded() async {
        let result = await networkProvider.fetchRequest()
        switch result {
        case .success(let token):
            try? keychain.saveValue(value: token, by: .accessToken)
        case .failure(let failure):
            print(failure)
        }
    }
}
