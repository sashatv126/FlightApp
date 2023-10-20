//
//  FlightsEndpoint.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import NetworkService

struct FlightEndpoinCreater: Endpoint {

    var baseUrl: String = "dsad"
    var path: String
    var parameters: [String: Any]?
    var data: Data?
    var header: HTTPHeaders
    var method: HTTPMethod
}

