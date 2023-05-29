//
//  AddCityModulePresenter.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import Foundation

final class AddCityModulePresenter {
    
    // MARK: - Internal properties
    
    weak var view: AddCityViewControllerInput?
    
    
    // MARK: - Private properties
    
    private let interactor: AddCityModuleInteractorInput
    
    
    // MARK: - Life cycle
    
    init(interactor: AddCityModuleInteractorInput) {
        self.interactor = interactor
    }
}


// MARK: - AddCityViewControllerOutput

extension AddCityModulePresenter: AddCityViewControllerOutput {
    func getCityWeather(city: String) {
        interactor.getCityWeather(city: city)
    }
}


// MARK: - AddCityModuleInteractorOutput

extension AddCityModulePresenter: AddCityModuleInteractorOutput {
    func setCityWeather(weather: CityCurrentWeatherModel) {
        view?.showCityWeather(weather: weather)
    }
}
