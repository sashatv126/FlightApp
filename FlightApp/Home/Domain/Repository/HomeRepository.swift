//
//  HomeRepository.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

protocol HomeRepositoryProtocol {
    func execute(dto: StartLocationDTO) async -> Result<Flights,DomainAPIError>
}

final class HomeRepository {
    private let apiDataSource: HomeAPIDataSourceProtocol

    init(apiDataSource: HomeAPIDataSourceProtocol) {
        self.apiDataSource = apiDataSource
    }
}

extension HomeRepository: HomeRepositoryProtocol {
    func execute(dto: StartLocationDTO) async -> Result<Flights,DomainAPIError> {
        let result = await apiDataSource.execute(dto: dto)
        switch result {
        case .success(let model):
            let domainModel = model.makeDomainModel()
            return .success(domainModel)
        case .failure(let error):
            return .failure(DomainAPIError(error: error))
        }
    }
}

