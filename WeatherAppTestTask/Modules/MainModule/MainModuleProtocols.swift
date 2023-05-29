//
//  MainModuleProtocols.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

protocol MainViewControllerInput: AnyObject {
    func showCurrentLocalWeather(weather: CurrentWeatherModel)
    func showDailyLocationWeather(dailyWeather: DailyWeatherModel)
}

protocol MainViewControllerOutput: AnyObject {
    func getWeatherCurrentDailyLocation()
    func getWeatcherSelectedLocation(coords: CityCoord)
}

protocol MainModuleInteractorInput: AnyObject {
    func getCurrentLocation()
    func getLocationWeather(lat: Double, lon: Double)
    func getDailyLocationWeather(lat: Double, lon: Double)
}

protocol MainModuleInteractorOutput: AnyObject {
    func setCurrentLocation(lat: Double, lon: Double)
    func setCurrentLocationWeather(weather: CurrentWeatherModel)
    func setDailyLocationWeather(dailyWeather: DailyWeatherModel)
}
