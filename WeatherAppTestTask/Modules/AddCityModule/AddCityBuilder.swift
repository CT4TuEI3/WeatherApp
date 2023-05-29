//
//  AddCityBuilder.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import UIKit

final class AddCityBuilder {
    static func createAddCityModuleBuilder() -> UIViewController {
        let service = NetworkService()
        let interactor = AddCityModuleInteractor(networkService: service)
        let presenter = AddCityModulePresenter(interactor: interactor)
        let view = AddCityViewController(output: presenter)
        presenter.view = view
        interactor.output = presenter
        return view
    }
}
