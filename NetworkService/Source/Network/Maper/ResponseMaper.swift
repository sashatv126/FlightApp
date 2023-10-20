//
//  ResponseMaper.swift
//  NetworkService
//
//  Created by Александр Александрович on 20.10.2023.
//

final class ResponseMaper {
    typealias Status = Int

    func mapResponse(data: Data,
                     response: URLResponse) -> Result<Data, ApiError> {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(.invalidResponse)
        }

        switch httpResponse.statusCode {
        case 200..<300:
            return .success(data)
        case 400:
            return .failure(.badRequest(request: response.url?.absoluteString ?? ""))
        case 404:
            return .failure(.notFound)
        case 500..<600:
            return .failure(.serverError)
        default: return .failure(.unknownError)
        }
    }
}
