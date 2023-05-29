//
//  CityCell.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import UIKit

final class CityCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    private let titleCityLabel = UILabel()
    private let temperatrueLabel = UILabel()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Configure
    
    func configure(cityWeather: CityCurrentWeatherModel) {
        titleCityLabel.text = cityWeather.name
        temperatrueLabel.text = String(Int(cityWeather.main.temp)) + "°"
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubview(titleCityLabel)
        addSubview(temperatrueLabel)
        titleCityLabel.text = "Город"
        titleCityLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        temperatrueLabel.text = "--"
        temperatrueLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        setConstraints()
    }
    
    private func setConstraints() {
        titleCityLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatrueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleCityLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleCityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            temperatrueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatrueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
