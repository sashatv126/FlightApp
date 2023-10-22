//
//  FlightsEndpoint.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import NetworkService
import KeychainManager

enum HomeEndpoint {

    case nearAirPort(entity: StartLocationDTO)
    case flights(entity: AirportDTO)

    var keychain: KeychainManager<AppKeys> {
        return KeychainManager<AppKeys>()
    }
}

extension HomeEndpoint: Endpoint {
    var baseUrl: String {
        return NetworkConstants.BaseURL.wb
    }
    
    var path: String {
        switch self {
        case .nearAirPort:
            return NetworkConstants.Paths.airports
        case .flights:
            return NetworkConstants.Paths.flights
        }

    }
    
    var parameters: [String : Any]? {
        switch self {
        case .nearAirPort(let entity):
            return ["latitude": entity.latitude,
                    "longitude": entity.longitude]
        case .flights(entity: let entity):
            return  ["departureAirportCode": entity.iataCode]
        }
    }
    
    var data: Data? {
        return nil
    }
    
    var header: HTTPHeaders {
        let token = keychain.loadValue(by: .accessToken, as: String.self)
        return ["Authorization":"Bearer \(token ?? "")"]
    }
    
    var method: HTTPMethod {
        switch self {
        case .nearAirPort:
            return .get
        case .flights:
            return .get
        }
    }
}
