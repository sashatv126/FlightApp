//
//  DomainAPIError.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import NetworkService

enum DomainAPIError: Error {
    case requestFailed(description: String)
    case invalidRequest
    case invalidData
    case jsonParsingFailure(description: String)
    case failedSerialization
    case noInternet
    case invalidResponse
    case notFound
    case badRequest(request: String)
    case serverError
    case unknownError

    var customDescription: String {
        switch self {
        case let .requestFailed(description): return "Request Failed: \(description)"
        case .invalidData: return "Invalid Data)"
        case let .jsonParsingFailure(description): return "JSON Parsing Failure \(description)"
        case .failedSerialization: return "Serialization failed."
        case .noInternet: return "No internet connection"
        case .invalidRequest: return "Invalid request data"
        case .serverError: return "Server error"
        case .invalidResponse: return "Invalid response"
        case .unknownError: return "Unknown error"
        case let .badRequest(request): return "Bad request \(request)"
        case .notFound: return "Endpoint not found"
        }
    }
}

extension DomainAPIError {
    init(error: ApiError) {
        switch error {
        case .requestFailed(description: let description):
            self = .requestFailed(description: description)
        case .invalidRequest:
            self = .invalidRequest
        case .invalidData:
            self = .invalidData
        case .jsonParsingFailure(description: let description):
            self = .jsonParsingFailure(description: description)
        case .failedSerialization:
            self = .failedSerialization
        case .noInternet:
            self = .noInternet
        case .invalidResponse:
            self = .invalidResponse
        case .notFound:
            self = .notFound
        case .badRequest(request: let request):
            self = .badRequest(request: request)
        case .serverError:
            self = .serverError
        case .unknownError:
            self = .unknownError
        }
    }
}

