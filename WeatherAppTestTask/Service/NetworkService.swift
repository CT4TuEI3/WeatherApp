//
//  NetworkService.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func getCurrentLocalWeather(lat: Double,
                                lon: Double,
                                completion: @escaping (CurrentWeatherModel) -> (),
                                completionError: @escaping (String) -> ())
    func getDailyLocalWeather(lat: Double,
                              lon: Double,
                              completion: @escaping (DailyWeatherModel) -> (),
                              completionError: @escaping (String) -> ())
    func getCityCurrentWeather(name: String,
                               completion: @escaping (CityCurrentWeatherModel) -> (),
                               completionError: @escaping (String) -> ())
}

final class NetworkService: NetworkServiceProtocol {
    private let minLongitude = 32.5
    private let maxLongitude = 36.5
    private let minLatitude = 44.0
    private let maxLatitude = 46.5
    
    func getCurrentLocalWeather(lat: Double,
                                lon: Double,
                                completion: @escaping (CurrentWeatherModel) -> (),
                                completionError: @escaping (String) -> ()) {
        let apiCall = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(NetworkProperties.API_KEY)&units=metric&lang=ru"
        guard let url = URL(string: apiCall) else { fatalError() }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                var currentWeather = try JSONDecoder().decode(CurrentWeatherModel.self, from: data)
                if currentWeather.coord.lat >= self.minLatitude &&
                    currentWeather.coord.lat <= self.maxLatitude &&
                    currentWeather.coord.lon >= self.minLongitude &&
                    currentWeather.coord.lon <= self.maxLongitude &&
                    currentWeather.sys.country == "UA"{
                    currentWeather.sys.country = "RU"
                }
                completion(currentWeather)
            } catch {
                completionError(error.localizedDescription)
            }
        }.resume()
    }
    
    func getDailyLocalWeather(lat: Double,
                              lon: Double,
                              completion: @escaping (DailyWeatherModel) -> (),
                              completionError: @escaping (String) -> ()) {
        let apiCall = "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly,alertsi&appid=\(NetworkProperties.API_KEY)&units=metric&lang=ru"
        guard let url = URL(string: apiCall) else { fatalError() }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let dailyWeather = try JSONDecoder().decode(DailyWeatherModel.self, from: data)
                completion(dailyWeather)
            } catch {
                completionError(error.localizedDescription)
            }
        }.resume()
    }
    
    func getCityCurrentWeather(name: String,
                               completion: @escaping (CityCurrentWeatherModel) -> (),
                               completionError: @escaping (String) -> ()) {
        let apiCall = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(NetworkProperties.API_KEY)&units=metric&lang=ru"
        let encodedURL = apiCall.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: encodedURL) else {
            fatalError()
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                var cityCurrentWeather = try JSONDecoder().decode(CityCurrentWeatherModel.self, from: data)
                if cityCurrentWeather.coord.lat >= self.minLatitude &&
                    cityCurrentWeather.coord.lat <= self.maxLatitude &&
                    cityCurrentWeather.coord.lon >= self.minLongitude &&
                    cityCurrentWeather.coord.lon <= self.maxLongitude &&
                    cityCurrentWeather.sys.country == "UA"{
                    cityCurrentWeather.sys.country = "RU"
                }
                completion(cityCurrentWeather)
            } catch {
                completionError(error.localizedDescription)
            }
        }.resume()
    }
}
