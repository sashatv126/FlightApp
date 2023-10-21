//
//  HomeNetworkProvider.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import NetworkService

protocol HomeNetworkProviderProtocol {
    func getFlights(dto: StartLocationDTO) -> Endpoint
}

final class HomeNetworkProvider: HomeNetworkProviderProtocol {
    func getFlights(dto: StartLocationDTO) -> Endpoint {
        let data = dto.toData()
        let endpoint = HomeEndpoint(path: NetworkConstants.Paths.getFlights,
                                    data: data,
                                    method: .post)
        return endpoint
    }
}
