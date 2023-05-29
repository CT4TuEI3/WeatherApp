//
//  MainModulePresenter.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

final class MainModulePresenter {
    
    // MARK: - Internal properties
    
    weak var view: MainViewControllerInput?
    
    
    // MARK: - Private properties
    
    private let interactor: MainModuleInteractorInput
    
    
    // MARK: - Life cycle
    
    init(interactor: MainModuleInteractorInput) {
        self.interactor = interactor
    }
}


// MARK: - MainViewControllerOutput

extension MainModulePresenter: MainViewControllerOutput {
    func getWeatherCurrentDailyLocation() {
        interactor.getCurrentLocation()
    }
    
    func getWeatcherSelectedLocation(coords: CityCoord) {
        interactor.getDailyLocationWeather(lat: coords.lat, lon: coords.lon)
    }
}


// MARK: - MainModuleInteractorOutput

extension MainModulePresenter: MainModuleInteractorOutput {
    func setCurrentLocation(lat: Double, lon: Double) {
        interactor.getLocationWeather(lat: lat, lon: lon)
        interactor.getDailyLocationWeather(lat: lat, lon: lon)
    }
    
    func setCurrentLocationWeather(weather: CurrentWeatherModel) {
        view?.showCurrentLocalWeather(weather: weather)
    }
    
    func setDailyLocationWeather(dailyWeather: DailyWeatherModel) {
        view?.showDailyLocationWeather(dailyWeather: dailyWeather)
    }
    
    func setErrorMessage(message: String) {
        view?.showErrorAlert(message: message)
    }
}
