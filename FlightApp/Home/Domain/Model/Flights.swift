//
//  Flights.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import Foundation

struct Flights {
    let data: [Flight]
}

// MARK: - Datum
struct Flight: Identifiable {
    let id = UUID()
    let name, iataCode: String
    let timeZone: Time?
}

// MARK: - TimeZone
struct Time {
    let offSet: String?
}
