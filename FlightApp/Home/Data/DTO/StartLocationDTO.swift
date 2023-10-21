//
//  StartLocationDTO.swift
//  FlightApp
//
//  Created by Александр Александрович on 20.10.2023.
//

struct StartLocationDTO: Encodable {
    let startLocationCode: String

    init(entity: StartLocationEntity) {
        self.startLocationCode = entity.startLocationCode
    }
}

