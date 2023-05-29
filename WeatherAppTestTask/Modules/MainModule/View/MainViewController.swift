//
//  MainViewController.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 24.05.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: Private properties
    
    private let controllerType: MainModuleType
    private let output: MainViewControllerOutput
    private let cityWeather: CityCurrentWeatherModel?
    private let dailyCellIdentifire = "dailyCellIdentifire"
    private var dailyWeatherData: [Daily] = []
    
    
    // MARK: UI Elements
    
    private let mainTableView = UITableView(frame: .zero, style: .insetGrouped)
    private let cityLabel = UILabel()
    private let temeperatureLabel = UILabel()
    private let discriptionWeatherLabel = UILabel()
    
    
    // MARK: Life cycle
    
    init(controllerType: MainModuleType, output: MainViewControllerOutput, cityWeather: CityCurrentWeatherModel?) {
        self.controllerType = controllerType
        self.output = output
        self.cityWeather = cityWeather
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if controllerType == .currentLocation {
            output.getWeatherCurrentDailyLocation()
        } else {
            guard let coords = cityWeather?.coord else { return }
            output.getWeatcherSelectedLocation(coords: coords)
        }
        setupUI()
    }
    
    
    // MARK: Private methods
    
    private func setupUI() {
        view.addSubviews([cityLabel,
                          temeperatureLabel,
                          discriptionWeatherLabel,
                          mainTableView])
        view.backgroundColor = .white
        settingsLabels()
        settingsTableView()
        setConstraints()
        setStartData()
        
        if controllerType == .currentLocation {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(showCityesWeather))
        }
    }
    
    private func setStartData() {
        if controllerType == .selectedLocation {
            self.cityLabel.text = cityWeather?.name
            self.temeperatureLabel.text = String(Int(cityWeather?.main.temp ?? 0.0)) + "°"
            self.discriptionWeatherLabel.text = cityWeather?.weather.first?.description ?? "Нет данных"
        }
    }
    
    private func settingsLabels() {
        cityLabel.text = "Город"
        cityLabel.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        temeperatureLabel.text = "--"
        temeperatureLabel.font = UIFont.systemFont(ofSize: 48, weight: .light)
        discriptionWeatherLabel.text = "Описание"
        discriptionWeatherLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
    }
    
    private func settingsTableView() {
        mainTableView.backgroundColor = .white
        mainTableView.isScrollEnabled = false
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.dataSource = self
        mainTableView.delegate = self
        mainTableView.register(DailyWeatherCell.self, forCellReuseIdentifier: dailyCellIdentifire)
    }
    
    private func setConstraints() {
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        temeperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        discriptionWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            temeperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            temeperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 8),
            
            discriptionWeatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            discriptionWeatherLabel.topAnchor.constraint(equalTo: temeperatureLabel.bottomAnchor, constant: 8),
            
            mainTableView.topAnchor.constraint(equalTo: discriptionWeatherLabel.bottomAnchor, constant: 40),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    // MARK: Actions
    
    @objc
    private func showCityesWeather() {
        let vc = AddCityBuilder.createAddCityModuleBuilder()
        navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: UITableViewDataSource, UITableViewDelegate

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dailyWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: dailyCellIdentifire,
                                                 for: indexPath) as? DailyWeatherCell
        cell?.configure(dailyWeather: dailyWeatherData[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let stackView = UIStackView()
        
        let sunIconImage = UIImageView(image: UIImage(systemName: "sun.max"))
        sunIconImage.contentMode = .scaleAspectFit
        
        let moonIconImage = UIImageView(image: UIImage(systemName: "moon.stars"))
        moonIconImage.contentMode = .scaleAspectFit
        
        header.backgroundColor = .white
        header.addSubview(stackView)
        stackView.addArrangedSubviews([UIView(),
                                       sunIconImage,
                                       moonIconImage])
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: header.centerXAnchor),
            stackView.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: header.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: header.bottomAnchor),
        ])
        return header
    }
}


// MARK: MainViewControllerInput

extension MainViewController: MainViewControllerInput {
    func showCurrentLocalWeather(weather: CurrentWeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.name
            self.temeperatureLabel.text = String(Int(weather.main.temp)) + "°"
            self.discriptionWeatherLabel.text = weather.weather.first?.description ?? "Нет данных"
        }
    }
    
    func showDailyLocationWeather(dailyWeather: DailyWeatherModel) {
        dailyWeatherData = dailyWeather.daily
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    
    func showErrorAlert(message: String) {
        showSystemErrorAlert(message: message)
    }
}
