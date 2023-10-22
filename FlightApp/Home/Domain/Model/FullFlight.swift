//
//  FullFlight.swift
//  FlightApp
//
//  Created by Александр Александрович on 23.10.2023.
//

import Foundation

typealias AllFlights = [FullInfoOfFlight]

struct FullInfoOfFlight: Identifiable {
    let id = UUID()
    let airport: Airport
    let flight: Flight
}
