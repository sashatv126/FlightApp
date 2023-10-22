//
//  TokenProvider.swift
//  TokenManager
//
//  Created by Александр Александрович on 22.10.2023.
//

import NetworkService

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

