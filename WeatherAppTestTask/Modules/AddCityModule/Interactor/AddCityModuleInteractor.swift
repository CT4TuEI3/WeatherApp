//
//  AddCityModuleInteractor.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

final class AddCityModuleInteractor {
    
    // MARK: - Internal properties
    
    weak var output: AddCityModuleInteractorOutput?
    
    
    // MARK: - Private properties

    private let networkService: NetworkServiceProtocol
    
    
    // MARK: - Life cycle

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}


// MARK: - AddCityModuleInteractorInput

extension AddCityModuleInteractor: AddCityModuleInteractorInput {
    func getCityWeather(city: String) {
        networkService.getCityCurrentWeather(name: city) { [weak self] cityWeather in
            self?.output?.setCityWeather(weather: cityWeather)
        } completionError: { [weak self] error in
            self?.output?.setError(message: error)
        }
    }
}
