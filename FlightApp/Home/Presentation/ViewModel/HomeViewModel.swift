//
//  HomeViewModel.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import Combine
import NetworkService

protocol HomeViewModelProtocol: ObservableObject {
    var flights: [Flight] { get }

    func viewDidAppear()
}

@MainActor final class HomeViewModel {
    @Published var flights: [Flight] = []
    private let getFlightsUseCase: GetFlightsUseCaseProtocol

    init(getFlightsUseCase: GetFlightsUseCaseProtocol) {
        self.getFlightsUseCase = getFlightsUseCase
    }
}

extension HomeViewModel: HomeViewModelProtocol {

    func viewDidAppear() {
        getFlights()
    }
}

private extension HomeViewModel {
    func getFlights() {
        let entity = StartLocationEntity()
        Task { [weak self] in
            let result = await self?.getFlightsUseCase.execute(entity: entity)
            guard let result else { return }
            switch result {
            case .success(let model):
                self?.flights = model.flights
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
