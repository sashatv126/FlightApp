//
//  Flights.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import Foundation

struct Flights {
    let flights: [Flight]
}

// MARK: - Flight
struct Flight: Identifiable {
    let id = UUID()
    let startDate: String
    let endDate: String
    let startLocationCode: String
    let endLocationCode: String
    let startCity: String
    let endCity: String
    let serviceClass: String
    let seats: [Seat]
    let price: Int
    let searchToken: String?
}

// MARK: - Seat
struct Seat: Codable {
    let passengerType: String
    let count: Int
}
