//
//  AddCityViewController.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import UIKit

final class AddCityViewController: UIViewController {
    
    // MARK: - Private propertyes
    
    private let output: AddCityViewControllerOutput
    private let cellIdentifire = "cellIdentifire"
    private var cityWeather: [CityCurrentWeatherModel] = []
    
    
    // MARK: - UI Elements
    
    private let cityesTableView = UITableView(frame: .zero, style: .insetGrouped)
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    init(output: AddCityViewControllerOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private Methods
    
    private func setupUI() {
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        view.addSubview(cityesTableView)
        settingsTableView()
        setConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(addCity))
    }
    
    private func settingsTableView() {
        cityesTableView.dataSource = self
        cityesTableView.delegate = self
        cityesTableView.register(CityCell.self, forCellReuseIdentifier: cellIdentifire)
        cityesTableView.backgroundColor = .white
    }
    
    private func setConstraints() {
        cityesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            cityesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - Actions
    
    @objc
    private func addCity() {
        let alert = UIAlertController(title: "Добавить город", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let cityTextField = (alert.textFields?.first)! as UITextField
        cityTextField.placeholder = "Введите название города"
        alert.addAction(UIAlertAction(title: "Добавить",
                                      style: .default,
                                      handler: { UIAlertAction in
            guard let cityName = cityTextField.text else { return }
            let userText = cityName.replacingOccurrences(of: " ", with: "")
            self.output.getCityWeather(city: userText)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .destructive))
        self.present(alert, animated: true)
    }
    
}

// MARK: UITableViewDataSource, UITableViewDelegate

extension AddCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire,
                                                 for: indexPath) as? CityCell
        cell?.configure(cityWeather: cityWeather[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MainModuleBuilder.createMainModuleBuilder(moduleType: .selectedLocation,
                                                           cityWeather: cityWeather[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        64
    }
}


// MARK: AddCityViewControllerInput

extension AddCityViewController: AddCityViewControllerInput {
    func showCityWeather(weather: CityCurrentWeatherModel) {
        cityWeather.append(weather)
        DispatchQueue.main.async {
            self.cityesTableView.reloadData()
        }
    }
}
