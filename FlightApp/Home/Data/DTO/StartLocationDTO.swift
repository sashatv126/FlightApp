//
//  StartLocationDTO.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

struct StartLocationDTO: Encodable {
    let latitude: Double
    let longitude: Double

    init(entity: StartLocationEntity) {
        self.latitude = entity.latitude
        self.longitude = entity.longitude
    }
}

