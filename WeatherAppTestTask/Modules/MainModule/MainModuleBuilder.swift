//
//  MainModuleBuilder.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import UIKit

final class MainModuleBuilder {
    static func createMainModuleBuilder(moduleType: MainModuleType,
                                        cityWeather: CityCurrentWeatherModel? = nil) -> UIViewController {
        let networkService = NetworkService()
        let locationService = LocationService()
        let interactor = MainModuleInteractor(networkService: networkService,
                                              locationService: locationService)
        let presenter = MainModulePresenter(interactor: interactor)
        let view = MainViewController(controllerType: moduleType,
                                      output: presenter,
                                      cityWeather: cityWeather)
        presenter.view = view
        interactor.output = presenter
        return view
    }
}
