//
//  NetworkConfig.swift
//  NetworkService
//
//  Created by Александр Александрович on 19.10.2023.
//

import Foundation

public protocol NetworkConfig {
    var configuration: URLSessionConfiguration { get }
    var timeout: TimeInterval { get }
    var networkServiceType: URLRequest.NetworkServiceType { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension NetworkConfig {
    func addSettingsToRequest(request: inout URLRequest) {
        request.timeoutInterval = timeout
        request.cachePolicy = cachePolicy
        request.networkServiceType = networkServiceType
    }
}

public struct DefaultNetworkServiceConfig: NetworkConfig {
    public var configuration: URLSessionConfiguration
    public var timeout: TimeInterval
    public var networkServiceType: URLRequest.NetworkServiceType
    public var cachePolicy: URLRequest.CachePolicy

    public init() {
        self.configuration = .default
        self.timeout = 20
        self.networkServiceType = .default
        self.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    }
}
