//
//  CityCurrentWeatherModel.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

struct CityCurrentWeatherModel: Decodable {
    let dt: Int
    let name: String
    let coord: CityCoord
    let sys: CitySys
    let main: CityMain
    let weather: [CityWeather]
}

struct CityCoord: Decodable {
    let lon: Double
    let lat: Double
}
struct CityWeather: Decodable {
    let description: String
}

struct CityMain: Decodable {
    let temp: Double
    let temp_min: Double?
    let temp_max: Double?
}

struct CitySys: Decodable {
    let country: String
}
