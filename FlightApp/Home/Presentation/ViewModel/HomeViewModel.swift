//
//  HomeViewModel.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import Combine
import NetworkService
import Location

protocol HomeViewModelProtocol: ObservableObject {
    var flights: [Flight] { get }

    func viewDidAppear()
}

@MainActor final class HomeViewModel {
    @Published var flights: [Flight] = []
    private let getFlightsUseCase: GetFlightsUseCaseProtocol
    private let locationManager: LocationManagerProtocol
    private var needToUpdate = true
    private var cancellables = Set<AnyCancellable>()

    init(getFlightsUseCase: GetFlightsUseCaseProtocol,
         locationManager: LocationManagerProtocol) {
        self.getFlightsUseCase = getFlightsUseCase
        self.locationManager = locationManager
    }
}

extension HomeViewModel: HomeViewModelProtocol {

    func viewDidAppear() {
//        locationManager.startMonitoringLocation()
//
//        locationManager.currentLocationPublisher
//            .sink { [weak self] currentLocation in
//                guard let currentLocation else { return }
//                let entity = StartLocationEntity(latitude: currentLocation.latitude,
//                                                longitude: currentLocation.longitude)
//                self?.getFlights(entity: entity)
//            }.store(in: &cancellables)
    }
}

private extension HomeViewModel {
    func getFlights(entity: StartLocationEntity) {
        guard needToUpdate else { return }
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
        needToUpdate = false
    }
}
