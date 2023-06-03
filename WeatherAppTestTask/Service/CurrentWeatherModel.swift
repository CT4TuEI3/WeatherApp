//
//  CurrentWeatherModel.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

struct CurrentWeatherModel: Decodable {
    let name: String
    var sys: CurrentSys
    let coord: CurrentCoods
    let main: CurrentMain
    let weather: [CurrentWeather]
    let dt: Int
}

struct CurrentCoods: Decodable {
    let lon: Double
    let lat: Double
}

struct CurrentMain: Decodable {
    let temp: Double
}

struct CurrentWeather: Decodable {
    let description: String
}

struct CurrentSys: Decodable {
    var country: String
}
