//
//  NearAirportDTO.swift
//  FlightApp
//
//  Created by Александр Александрович on 22.10.2023.
//

struct NearAirportDTO: Decodable {
    let data: [AirportDTO]
}

struct AirportDTO: Decodable {
    let iataCode: String
    let address: AirportAdressDTO

    init(entity: Airport) {
        self.iataCode = entity.iataCode
        self.address = .init(entity: entity.address)
    }
}

struct AirportAdressDTO: Decodable {
    let cityName: String

    init(entity: AirportAdress) {
        self.cityName = entity.cityName
    }
}

extension AirportDTO {
    func makeDomainModel() -> Airport {
        Airport(iataCode: iataCode,
                address: address.makeDomainModel())
    }
}

extension AirportAdressDTO {
    func makeDomainModel() -> AirportAdress {
        AirportAdress(cityName: cityName)
    }
}

