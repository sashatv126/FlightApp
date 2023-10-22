//
//  Airport.swift
//  FlightApp
//
//  Created by Александр Александрович on 23.10.2023.
//

struct Airport: Decodable {
    let iataCode: String
    let address: AirportAdress
}

struct AirportAdress: Decodable {
    let cityName: String
}
