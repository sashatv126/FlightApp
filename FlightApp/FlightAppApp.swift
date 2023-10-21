//
//  FlightAppApp.swift
//  FlightApp
//
//  Created by Александр Александрович on 19.10.2023.
//

import SwiftUI
import SwiftData
import NetworkService

@main
struct FlightAppApp: App {
    private let factory = HomeFactory()

    var body: some Scene {
        WindowGroup {
            factory.makeHomeView()
        }
    }
}


protocol HomeFactoryViewProtocol {

}

struct HomeFactory: HomeFactoryViewProtocol {
    @MainActor func makeHomeView() -> ContentView<HomeViewModel> {
        let networkService = NetworkService()
        let networkProvider = NetworkProvider(networkService: networkService)
        let provider = HomeNetworkProvider()
        let apiDataSource = HomeAPIDataSource(provider: provider,
                                              networkProvider: networkProvider)
        let repository = HomeRepository(apiDataSource: apiDataSource)
        let getFlightsUseCase = GetFlightsUseCase(repository: repository)
        let viewModel = HomeViewModel(getFlightsUseCase: getFlightsUseCase)
        let view = ContentView(vm: viewModel)
        return view
    }
}
