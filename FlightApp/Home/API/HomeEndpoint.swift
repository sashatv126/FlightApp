//
//  FlightsEndpoint.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import NetworkService

enum HomeEndpoint {

    case nearAirPort(entity: StartLocationDTO)
}

extension HomeEndpoint: Endpoint {
    var baseUrl: String {
        return NetworkConstants.BaseURL.wb
    }
    
    var path: String {
        return NetworkConstants.Paths.getFlights
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .nearAirPort(let entity):
            return ["latitude": entity.latitude,
                    "longitude": entity.longitude]
        }
    }
    
    var data: Data? {
        switch self {
        case .nearAirPort:
            return nil
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization":"Bearer \(NetworkConstants.APIKey.flightsApiKey)"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .nearAirPort:
            return .get
        }
    }
}
