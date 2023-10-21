//
//  NetworkConstants.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

enum NetworkConstants {
    enum BaseURL {
        static let wb = "https://vmeste.wildberries.ru"
    }

    enum Paths {
        static let getFlights = "stream/api/avia-service/v1/suggests/getCheap"
    }
}
