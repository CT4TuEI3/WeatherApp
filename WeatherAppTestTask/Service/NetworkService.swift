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
    /// Метод проверяет координаты запрашиваемого города и страну.
    /// Если координаты города совпадают с координатами п-овом Крым, то страна запрашиваемого города меняется на Россию.
    /// - Parameters:
    ///   - lat: долгота города
    ///   - lon: широта города
    ///   - sys: страна города из сервиса
    /// - Returns: корректную страну
    private func updateCountry(lat: Double, lon: Double, sys: String) -> String {
        let minLatitude = 44.0
        let maxLatitude = 46.5
        let minLongitude = 32.5
        let maxLongitude = 36.5
        if lat >= minLatitude &&
            lat <= maxLatitude &&
            lon >= minLongitude &&
            lon <= maxLongitude &&
            sys == "UA"{
            return "RU"
        } else {
            return sys
        }
    }
    
    /// Запрос текущей погоды по текущей геолокации.
    /// - Parameters:
    ///   - lat: Широта текущего местоположения
    ///   - lon: Долгота текущего местоположения
    ///   - completion: Текущая погода
    ///   - completionError: Ошибка
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
                currentWeather.sys.country = self.updateCountry(lat: currentWeather.coord.lat,
                                                                lon: currentWeather.coord.lat,
                                                                sys: currentWeather.sys.country)
                completion(currentWeather)
            } catch {
                completionError(error.localizedDescription)
            }
        }.resume()
    }
    
    /// Прогноз погоды по дням на неделю по координатам
    /// - Parameters:
    ///   - lat: Долгота
    ///   - lon: Широта
    ///   - completion: Прогноз погоды на неделю
    ///   - completionError: Ошибка
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
    
    /// Текущая погода в городе
    /// - Parameters:
    ///   - name: Название города
    ///   - completion: Погода в городе
    ///   - completionError: Ошибка
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
                cityCurrentWeather.sys.country = self.updateCountry(lat: cityCurrentWeather.coord.lat,
                                                                    lon: cityCurrentWeather.coord.lon,
                                                                    sys: cityCurrentWeather.sys.country)
                completion(cityCurrentWeather)
            } catch {
                completionError(error.localizedDescription)
            }
        }.resume()
    }
}
