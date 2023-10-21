//
//  HomeViewFactory.swift
//  FlightApp
//
//  Created by Александр Александрович on 21.10.2023.
//

import NetworkService
import SwiftUI

protocol HomeViewFactoryProtocol {
    @MainActor func makeHomeView() -> ContentView<HomeViewModel>
    func makeDetailView() -> EmptyView
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

    func makeDetailView() -> EmptyView {
        return EmptyView()
    }
}

protocol ProviderFactoryProtocol {

}

final class ProviderFactory {
    
}

protocol HomeAPIDataSourceFactory {

}
