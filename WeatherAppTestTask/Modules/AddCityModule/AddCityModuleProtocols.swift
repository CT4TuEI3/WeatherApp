//
//  AddCityModuleProtocols.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

protocol AddCityViewControllerInput: AnyObject {
    func showCityWeather(weather: CityCurrentWeatherModel)
}

protocol AddCityViewControllerOutput: AnyObject {
    func getCityWeather(city: String)
}

protocol AddCityModuleInteractorInput: AnyObject {
    func getCityWeather(city: String)
}

protocol AddCityModuleInteractorOutput: AnyObject {
    func setCityWeather(weather: CityCurrentWeatherModel)
}
