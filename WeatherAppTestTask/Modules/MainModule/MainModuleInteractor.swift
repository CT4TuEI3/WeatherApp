//
//  MainModuleInteractor.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

final class MainModuleInteractor {
    
    // MARK: - Internal properties
    
    weak var output: MainModuleInteractorOutput?
    
    
    // MARK: - Private properties
    
    private let networkService: NetworkServiceProtocol
    private let locationService: LocationServiceProtocol
    
    
    // MARK: - Life cycle
    
    init(networkService: NetworkServiceProtocol, locationService: LocationServiceProtocol) {
        self.networkService = networkService
        self.locationService = locationService
    }
}


// MARK: - MainModuleInteractorInput

extension MainModuleInteractor: MainModuleInteractorInput {
    func getCurrentLocation() {
        locationService.getLocation { [weak self] lat, lon in
            self?.output?.setCurrentLocation(lat: lat, lon: lon)
        }
    }
    
    func getLocationWeather(lat: Double, lon: Double) {
        networkService.getCurrentLocalWeather(lat: lat, lon: lon) { [weak self] weather in
            self?.output?.setCurrentLocationWeather(weather: weather)
        } completionError: { [weak self] error in
            self?.output?.setErrorMessage(message: error)
        }
    }
    
    func getDailyLocationWeather(lat: Double, lon: Double) {
        networkService.getDailyLocalWeather(lat: lat, lon: lon) { [weak self] dailyWeather in
            self?.output?.setDailyLocationWeather(dailyWeather: dailyWeather)
        } completionError: { [weak self] error in
            self?.output?.setErrorMessage(message: error)
        }
    }
}
