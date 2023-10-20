//
//  Network.swift
//  NetworkService
//
//  Created by Александр Александрович on 19.10.2023.
//

import Foundation

public protocol NetworkServiceProtocol {
    func fetchRequest(endpoint: Endpoint) async throws -> Result<Data, ApiError>
}

public final class NetworkService {
    private let config: NetworkConfig
    private let session: URLSession
    private let responseMaper = ResponseMaper()

    public init(config: NetworkConfig = DefaultNetworkServiceConfig()) {
        self.config = config
        session = URLSession(configuration: config.configuration)
    }
}

extension NetworkService: NetworkServiceProtocol {
    public func fetchRequest(endpoint: Endpoint) async throws -> Result<Data, ApiError> {
        let request = endpoint.makeRequest()
        guard var request else { return .failure(.invalidRequest) }
        config.addSettingsToRequest(request: &request)

        do {
            let (data, response) = try await session.data(for: request)
            guard let response = response as? HTTPURLResponse else { fatalError() }

            let dataString = String(decoding: data, as: UTF8.self)
            print("----------------------------------------------------")
            print("===Request Url      --->>> \(request.url!)")
            print("===Request headers  --->>> \(request.allHTTPHeaderFields!)")
            print("===Response Code    --->>> \(response.statusCode)")
            print("===Response Data    --->>> \(dataString)")
            print("----------------------------------------------------")

            let result = responseMaper.mapResponse(data: data, response: response)
            return result
        } catch {
            return .failure(.unknownError)
        }
    }
}
