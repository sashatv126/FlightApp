//
//  ManagerFactory.swift
//  FlightApp
//
//  Created by Александр Александрович on 22.10.2023.
//

import UIKit
import Location

protocol ManagerFactoryProtocol {
    func createLocationManager() -> LocationManagerProtocol
}

final class ManagerFactory {}

extension ManagerFactory: ManagerFactoryProtocol {
    func createLocationManager() -> LocationManagerProtocol {
        LocationManager()
    }
}
