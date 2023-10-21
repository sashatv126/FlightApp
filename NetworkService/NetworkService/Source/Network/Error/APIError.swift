//
//  APIError.swift
//  NetworkService
//
//  Created by Александр Александрович on 19.10.2023.
//

public enum ApiError: Error {
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

    public var customDescription: String {
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
