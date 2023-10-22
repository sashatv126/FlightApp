//
//  FlightsDTO.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

import Foundation

// MARK: - Empty
struct FlightsDTO: Codable {
    let data: [FlightDTO]
}

// MARK: - Datum
struct FlightDTO: Codable {
    let name, iataCode: String?
    let timeZone: TimeDTO?
}

// MARK: - TimeZone
struct TimeDTO: Codable {
    let offSet: String?
}

extension FlightsDTO {
    func makeDomainModel() -> Flights {
        let flights = data.compactMap { $0.makeDomainModel() }
        return Flights(data: flights)
    }
}

extension FlightDTO {
    func makeDomainModel() -> Flight {
        let timeZone = timeZone?.makeDomainModel()
        return Flight(name: name ?? "",
               iataCode: iataCode ?? "",
               timeZone: timeZone)
    }
}

extension TimeDTO {
    func makeDomainModel() -> Time {
        Time(offSet: offSet)
    }
}
