//
//  HomeNetworkProvider.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import NetworkService

protocol HomeNetworkProviderProtocol {
    func getAirport(dto: StartLocationDTO) -> Endpoint
    func getFlights(dto: AirportDTO) -> Endpoint
}

final class HomeNetworkProvider: HomeNetworkProviderProtocol {
    func getAirport(dto: StartLocationDTO) -> Endpoint {
        let endpoint = HomeEndpoint.nearAirPort(entity: dto)
        return endpoint
    }

    func getFlights(dto: AirportDTO) -> Endpoint {
        let endpoint = HomeEndpoint.flights(entity: dto)
        return endpoint
    }
}
