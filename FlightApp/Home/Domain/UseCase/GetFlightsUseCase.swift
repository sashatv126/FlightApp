//
//  GetFlightsUseCase.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

protocol GetFlightsUseCaseProtocol {
    func execute(entity: StartLocationEntity) async -> Result<Flights,DomainAPIError>
}

final class GetFlightsUseCase {
    private let repository: HomeRepositoryProtocol

    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }
}

extension GetFlightsUseCase: GetFlightsUseCaseProtocol {
    func execute(entity: StartLocationEntity) async -> Result<Flights,DomainAPIError> {
        let dto = StartLocationDTO(entity: entity)
        let result = await repository.execute(dto: dto)
        switch result {
        case .success(let model):
            let sortedModel = sortByDepartureDate(model: model)
            return .success(sortedModel)
        case .failure(let error):
            return .failure(error)
        }
    }
}

private extension GetFlightsUseCase {
    func sortByDepartureDate(model: Flights) -> Flights {
        let sortedFlights = model.flights.sorted(by: { $0.endCity > $1.endCity })
        return Flights(flights: sortedFlights)
    }
}
