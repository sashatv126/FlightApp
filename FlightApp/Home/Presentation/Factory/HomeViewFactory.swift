//
//  HomeViewFactory.swift
//  FlightApp
//
//  Created by Александр Александрович on 21.10.2023.
//

import NetworkService

protocol HomeViewFactoryProtocol {
    @MainActor func makeHomeView() -> ContentView<HomeViewModel>
}

struct HomeViewFactory: HomeViewFactoryProtocol {
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
