//
//  ApiTokenService.swift
//  FlightApp
//
//  Created by Александр Александрович on 22.10.2023.
//

import Foundation
import KeychainManager
import NetworkService

typealias AccessToken = String

protocol ApiTokenServiceProtocol {
    func getAndSaveAccessTokenIfNeeded()
    func getAccessToken() -> AccessToken?
}

final class ApiTokenService<Keychain: KeychainManagerProtocol> where Keychain.Key == TokenServiceKey {

    let keychain: Keychain
    let networkProvider: TokenNetworkProvider

    init(keychain: Keychain,
         networkProvider: TokenNetworkProvider) {
        self.keychain = keychain
        self.networkProvider = networkProvider
    }
}

extension ApiTokenService: ApiTokenServiceProtocol {
    func getAndSaveAccessTokenIfNeeded() {
    }

    func getAccessToken() -> AccessToken? {
        keychain.loadValue(by: .accessToken, as: String.self)
    }
}

protocol TokenNetworkProviderProtocol {
    func fetchRequest() async ->Result<AccessToken,ApiError>
}

final class TokenNetworkProvider {
    private let networkProvider: NetworkProviderProtocol

    init(networkProvider: NetworkProviderProtocol) {
        self.networkProvider = networkProvider
    }
}

extension TokenNetworkProvider: TokenNetworkProviderProtocol {
    func fetchRequest() async -> Result<AccessToken,ApiError> {
        let endpoint = TokenEndpoint.token
        let result = await networkProvider.execute(endpoint: endpoint,
                                                   modelType: UserData.self)
        let mappedResult = result.map { $0.accessToken ?? "" }
        return mappedResult
    }
}

enum TokenServiceKey: String, KeychainKey {
    case accessToken
}

