//
//  NetworkService.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCurrentLocalWeather(lat: Double, lon: Double, completion: @escaping (CurrentWeatherModel) -> ())
    func getDailyLocalWeather(lat: Double, lon: Double, completion: @escaping (DailyWeatherModel) -> ())
    func getCityCurrentWeather(name: String, completion: @escaping (CityCurrentWeatherModel) -> ())
}

final class NetworkService: NetworkServiceProtocol {
    func getCurrentLocalWeather(lat: Double, lon: Double, completion: @escaping (CurrentWeatherModel) -> ()) {
        let apiCall = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(NetworkProperties.API_KEY)&units=metric&lang=ru"
        guard let url = URL(string: apiCall) else {
            fatalError()
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let currentWeather = try JSONDecoder().decode(CurrentWeatherModel.self, from: data)
                completion(currentWeather)
            } catch {
                print("Error parcing current weather")
            }
        }.resume()
    }
    
    func getDailyLocalWeather(lat: Double, lon: Double, completion: @escaping (DailyWeatherModel) -> ()) {
        let apiCall = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly,alertsi&appid=\(NetworkProperties.API_KEY)&units=metric&lang=ru"
        guard let url = URL(string: apiCall) else {
            fatalError()
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let dailyWeather = try JSONDecoder().decode(DailyWeatherModel.self, from: data)
                completion(dailyWeather)
            } catch {
                print("Error parcing daily weather")
            }
        }.resume()
    }
    
    func getCityCurrentWeather(name: String, completion: @escaping (CityCurrentWeatherModel) -> ()) {
        let apiCall = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(NetworkProperties.API_KEY)&units=metric&lang=ru"
        let encodedURL = apiCall.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: encodedURL) else {
            fatalError()
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let cityCurrentWeather = try JSONDecoder().decode(CityCurrentWeatherModel.self, from: data)
                completion(cityCurrentWeather)
            } catch {
                print("Error parcing city current weather")
            }
        }.resume()
    }
}
