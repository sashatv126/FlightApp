//
//  TokenEndpoint.swift
//  TokenManager
//
//  Created by Александр Александрович on 22.10.2023.
//

import NetworkService

enum TokenEndpoint {
    case token
}

extension TokenEndpoint: Endpoint {
    var baseUrl: String {
        return NetworkConstants.BaseURL.amadeus
    }

    var path: String {
        return NetworkConstants.Paths.token
    }

    var parameters: [String : Any]? {
        switch self {
        case .token:
            return [:]
        }
    }

    var data: Data? {
        switch self {
        case .token:
            let clientID = APIConstants.apiKey
            let clientSecret =  APIConstants.apiSecret
            let bodyString = "grant_type=client_credentials&client_id=\(clientID)&client_secret=\(clientSecret)"
           return bodyString.data(using: .utf8)
        }
    }

    var header: HTTPHeaders {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }

    var method: HTTPMethod {
        switch self {
        case .token:
            return .post
        }
    }
}
