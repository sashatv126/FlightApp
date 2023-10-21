//
//  NetworkProvider.swift
//  NetworkService
//
//  Created by Александр Александрович on 20.10.2023.
//

public protocol NetworkProviderProtocol {
    func execute<Model: Decodable>(endpoint: Endpoint, modelType: Model.Type) async -> Result<Model, ApiError>
}

final public class NetworkProvider: NetworkProviderProtocol {
    private let networkService: NetworkServiceProtocol

    public init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    public func execute<Model: Decodable>(endpoint: Endpoint, modelType: Model.Type) async -> Result<Model, ApiError> {
        do {
            let networkResult = try await networkService.fetchRequest(endpoint: endpoint)

            switch networkResult {
            case .success(let data):
                let parser = APIParseService<Model>()
                let parseResult = parser.parse(data: data)

                switch parseResult {
                case .success(let model):
                    return .success(model)

                case .failure(let error):
                    return .failure(error)
                }

            case .failure(let failure):
                return .failure(failure)
            }
        } catch {
            return .failure(.unknownError)
        }
    }
}

