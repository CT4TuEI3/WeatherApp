//
//  DeilyWeatherCell.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 27.05.2023.
//

import UIKit

final class DailyWeatherCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    private let dayLabel = UILabel()
    private let elementsStackView = UIStackView()
    private let nightTempLabel = UILabel()
    private let dayTempLabel = UILabel()
    private let iconWeatherLabel = UILabel()
    
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configure
    
    func configure(dailyWeather: Daily) {
        dayLabel.text = String(getDayOfWeek(from: dailyWeather.dt) ?? "")
        nightTempLabel.text = String(Int(dailyWeather.temp.night)) + "°"
        dayTempLabel.text = String(Int(dailyWeather.temp.day)) + "°"
        iconWeatherLabel.text = getEmojiFromIcon(iconName: dailyWeather.weather.first?.icon ?? "")
    }
    
    
    // MARK: - Private methods
    
    private func setupUI() {
        addSubviews([dayLabel, elementsStackView])
        elementsStackView.addArrangedSubviews([iconWeatherLabel,
                                               nightTempLabel,
                                               dayTempLabel])
        elementsStackView.spacing = 16
        elementsStackView.distribution = .fillEqually
        iconWeatherLabel.textAlignment = .center
        dayTempLabel.textAlignment = .center
        nightTempLabel.textAlignment = .center
        
        selectionStyle = .none
        setConstraints()
    }
    
    /// Функция принимает название иконки погоды из прогноза и конвертит в дефолтные смайлики эпла
    /// - Parameter iconName: Иконка из сервиса
    /// - Returns: Дефолтный смайлик
    private func getEmojiFromIcon(iconName: String) -> String {
        switch iconName {
            case "01d":
                return "☀️"
            case "01n":
                return "🌘"
            case "02d":
                return "⛅️"
            case "02n":
                return "☁️"
            case "03d", "03n", "04d", "04n":
                return "☁️"
            case "09d", "09n", "10d", "10n":
                return "🌧"
            case "11d", "11n":
                return "⛈️"
            case "13d", "13n":
                return "❄️"
            case "50d", "50n":
                return "😶‍🌫️"
            default:
                return ""
        }
    }
    
    private func getDayOfWeek(from date: Int) -> String? {
        let convertedDate = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        return dateFormatter.string(from: convertedDate)
    }
    
    private func setConstraints() {
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        elementsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: topAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dayLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            dayLabel.heightAnchor.constraint(equalToConstant: 44),
            
            elementsStackView.leadingAnchor.constraint(equalTo: centerXAnchor),
            elementsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            elementsStackView.topAnchor.constraint(equalTo: topAnchor),
            elementsStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
