//
//  GetFlightsUseCase.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

protocol GetFlightsUseCaseProtocol {
    func execute(entity: StartLocationEntity) async -> Result<AllFlights,DomainAPIError>
}

final class GetFlightsUseCase {
    private let repository: HomeRepositoryProtocol

    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
}

extension GetFlightsUseCase: GetFlightsUseCaseProtocol {
    func execute(entity: StartLocationEntity) async -> Result<AllFlights,DomainAPIError> {
        let dto = StartLocationDTO(entity: entity)
        let result = await repository.execute(dto: dto)
        switch result {
        case .success(let airport):
            let dto = AirportDTO(entity: airport)
            let result = await repository.execute(dto: dto)
            switch result {
            case .success(let flights):
                let allFlights = flights.data.map { FullInfoOfFlight(airport: airport,
                                                                     flight: $0)}
                return .success(allFlights)
            case .failure(let error):
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}
