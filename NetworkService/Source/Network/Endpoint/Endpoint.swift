//
//  Endpoint.swift
//  NetworkService
//
//  Created by Александр Александрович on 20.10.2023.
//

public typealias HTTPHeaders = [String:String]?

public protocol Endpoint {
    var baseUrl: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var data: Data? { get }
    var header: HTTPHeaders { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    func makeRequest() -> URLRequest? {
        let urlString = baseUrl + "/" + path
        guard var urlComponents = URLComponents(string: urlString) else { return nil }
        let queryItems = parameters?.map({ key, value in return URLQueryItem(name: key, value: "\(value)") })
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpBody = data
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}

public enum HTTPMethod: String {
    case get =    "GET"
    case post =   "POST"
    case put =    "PUT"
    case patch =  "PATCH"
    case delete = "DELETE"
}
