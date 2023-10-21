//
//  FlightsEndpoint.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import NetworkService

struct HomeEndpoint: Endpoint {

    var baseUrl: String = NetworkConstants.BaseURL.wb
    var path: String
    var parameters: [String: Any]?
    var data: Data?
    var header: HTTPHeaders = [:]
    var method: HTTPMethod
}

