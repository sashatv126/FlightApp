//
//  FlightsDTO.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

struct FlightsDTO: Codable {
    let flights: [FlightDTO]
}

// MARK: - Flight
struct FlightDTO: Codable {
    let startDate: String
    let endDate: String
    let startLocationCode: String
    let endLocationCode: String
    let startCity: String
    let endCity: String
    let serviceClass: String?
    let seats: [SeatDTO]
    let price: Int
    let searchToken: String?
}

// MARK: - Seat
struct SeatDTO: Codable {
    let passengerType: String?
    let count: Int?
}

extension FlightsDTO {
    func makeDomainModel() -> Flights {
        let flights = flights.map { $0.makeDomainModel() }
        return Flights(flights: flights)
    }
}

extension FlightDTO {
    func makeDomainModel() -> Flight {
        let seats = seats.map { $0.makeDomainModel() }
        return Flight(startDate: startDate,
               endDate: endDate,
               startLocationCode: startLocationCode,
               endLocationCode: endLocationCode,
               startCity: startCity,
               endCity: endCity,
               serviceClass: serviceClass ?? "",
               seats: seats,
               price: price,
               searchToken: searchToken)
    }
}

extension SeatDTO {
    func makeDomainModel() -> Seat {
        return Seat(passengerType: passengerType ?? "",
                    count: count ?? 0)
    }
}
