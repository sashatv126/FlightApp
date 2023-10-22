//
//  LocationManager.swift
//  FlightApp
//
//  Created by Александр Александрович on 22.10.2023.
//

import CoreLocation
import Combine

protocol LocationManagerProtocol {
    var currentLocationPublisher: Published<CLLocationCoordinate2D?>.Publisher { get }

    func startMonitoringLocation()
    func stopMonitoringLocation()
}

class LocationManager: NSObject {
    private let locationManager: CLLocationManager
    @Published private var currentLocation: CLLocationCoordinate2D?
    @Published private var authorizationStatus: CLAuthorizationStatus

    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        self.authorizationStatus = locationManager.authorizationStatus

        super.init()

        locationManager.delegate = self
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.authorizationStatus = manager.authorizationStatus
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last?.coordinate
    }
}

extension LocationManager: LocationManagerProtocol {
    var currentLocationPublisher: Published<CLLocationCoordinate2D?>.Publisher { $currentLocation }

    func startMonitoringLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    func stopMonitoringLocation() {
        locationManager.stopUpdatingLocation()
    }
}
