//
//  AddCityModuleProtocols.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

protocol AddCityViewControllerInput: AnyObject {
    func showCityWeather(weather: CityCurrentWeatherModel)
    func showErrorAlert(message: String)
}

protocol AddCityViewControllerOutput: AnyObject {
    func getCityWeather(city: String)
}

protocol AddCityModuleInteractorInput: AnyObject {
    func getCityWeather(city: String)
}

protocol AddCityModuleInteractorOutput: AnyObject {
    func setCityWeather(weather: CityCurrentWeatherModel)
    func setError(message: String)
}
