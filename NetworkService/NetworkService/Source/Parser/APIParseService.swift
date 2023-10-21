//
//  APIParseService.swift
//  NetworkService
//
//  Created by Александр Александрович on 20.10.2023.
//

final class APIParseService<Model: Decodable> {
    private let decoder = JSONDecoder()

    init(keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) {
        decoder.keyDecodingStrategy = keyDecodingStrategy
    }

    func parse(data: Data) -> Result<Model,ApiError> {
        do {
            let model = try decoder.decode(Model.self, from: data)
            return .success(model)
        } catch let error {
            return .failure(.jsonParsingFailure(description: error.localizedDescription))
        }
    }
}
