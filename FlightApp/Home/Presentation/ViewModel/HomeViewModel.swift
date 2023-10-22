//
//  HomeViewModel.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import Combine
import NetworkService
import KeychainManager
import TokenManager

protocol HomeViewModelProtocol: ObservableObject {
    var flights: AllFlights { get }

    func viewDidAppear()
}

@MainActor final class HomeViewModel {
    @Published var flights: AllFlights = []
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

enum AppKeys: String, KeychainKey {
    case accessToken
}

extension HomeViewModel: HomeViewModelProtocol {

    func viewDidAppear() {
        locationManager.startMonitoringLocation()
        let entity = StartLocationEntity(latitude: 32,
                                        longitude: -119)
        self.getFlights(entity: entity)
        locationManager.currentLocationPublisher
            .sink { [weak self] currentLocation in
                guard let currentLocation else { return }
//                let entity = StartLocationEntity(latitude: currentLocation.latitude,
//                                                longitude: currentLocation.longitude)
//                self?.getFlights(entity: entity)
            }.store(in: &cancellables)
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
                self?.flights = model
            case .failure(let failure):
                print(failure)
            }
        }
        needToUpdate = false
    }
}
