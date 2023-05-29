//
//  DailyWeatherModel.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

struct DailyWeatherModel: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let daily: [Daily]
}

struct Daily: Decodable {
    let dt: Int
    let temp: DeilyTemp
    let weather: [DailyWeather]
}

struct DeilyTemp: Decodable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
}

struct DailyWeather: Decodable {
    let icon: String
}
