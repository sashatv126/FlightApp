//
//  HomeAPIDataSource.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import NetworkService

protocol HomeAPIDataSourceProtocol {
    func execute(dto: StartLocationDTO) async -> Result<NearAirportDTO,ApiError>
    func execute(dto: AirportDTO) async -> Result<FlightsDTO,ApiError>
}

final class HomeAPIDataSource {
    private let provider: HomeNetworkProviderProtocol
    private let networkProvider: NetworkProviderProtocol

    init(provider: HomeNetworkProviderProtocol,
         networkProvider: NetworkProviderProtocol) {
        self.provider = provider
        self.networkProvider = networkProvider
    }
}

extension HomeAPIDataSource: HomeAPIDataSourceProtocol {
    func execute(dto: StartLocationDTO) async -> Result<NearAirportDTO,ApiError> {
        let endpoint = provider.getAirport(dto: dto)
        let result = await networkProvider.execute(endpoint: endpoint,
                                                   modelType: NearAirportDTO.self)
        return result
    }

    func execute(dto: AirportDTO) async -> Result<FlightsDTO,ApiError> {
        let endpoint = provider.getFlights(dto: dto)
        let result = await networkProvider.execute(endpoint: endpoint,
                                                   modelType: FlightsDTO.self)
        return result
    }
}
