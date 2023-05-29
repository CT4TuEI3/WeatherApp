//
//  LocationService.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import CoreLocation

protocol LocationServiceProtocol {
    func getLocation(competion: @escaping (Double, Double) -> Void)
}

class LocationService: NSObject, LocationServiceProtocol {
    
    // MARK: - Private properties
    
    private let locationManager = CLLocationManager()
    private var locationCompletion: ((Double, Double) -> Void)?
    
    
    // MARK: Functions
    
    func getLocation(competion completion: @escaping (Double, Double) -> Void) {
        locationManager.requestWhenInUseAuthorization()
        locationCompletion = completion
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                self.locationManager.pausesLocationUpdatesAutomatically = false
                self.locationManager.startUpdatingLocation()
            }
        }
    }
}


// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationCompletion?(location.coordinate.latitude, location.coordinate.longitude)
        locationManager.stopUpdatingLocation()
    }
}
