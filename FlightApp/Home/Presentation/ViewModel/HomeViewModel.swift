//
//  HomeViewModel.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import Combine
import NetworkService

protocol HomeViewModelProtocol: ObservableObject {
    var text: String { get }

    func buttonTapped()
}

final class HomeViewModel {
    @Published var text = "V"
}

extension HomeViewModel: HomeViewModelProtocol {

    struct A: Encodable {
        let startLocationCode: String
    }

    func buttonTapped() {
        let networkService = NetworkService()
        let provider = NetworkProvider(networkService: networkService)
        let headers: [String: String] = ["startLocationCode": "LED"]
        let data = A(startLocationCode: "LED").toData()
        let endpoint = FlightEndpoinCreater(baseUrl: NetworkConstants.BaseURL.wb,path: NetworkConstants.Paths.getCheap, data: data, header: headers, method: .post)
        Task {
            let result = await provider.execute(endpoint: endpoint, modelType: String.self)
            print(result)
        }
    }
}
