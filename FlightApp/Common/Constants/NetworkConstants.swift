//
//  NetworkConstants.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

enum NetworkConstants {
    enum BaseURL {
        static let wb = "https://test.api.amadeus.com"
    }

    enum Paths {
        static let getFlights = "v1/reference-data/locations/airports"
    }

    enum APIKey {
        static let flightsApiKey = "BtJ4mVfD61l5GzhPBiRKXVdafDPj"
    }
}
