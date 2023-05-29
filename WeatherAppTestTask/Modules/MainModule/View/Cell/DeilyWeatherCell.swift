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
        addSubview(dayLabel)
        addSubview(nightTempLabel)
        addSubview(dayTempLabel)
        addSubview(iconWeatherLabel)
        selectionStyle = .none
        setConstraints()
    }
    
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
        nightTempLabel.translatesAutoresizingMaskIntoConstraints = false
        dayTempLabel.translatesAutoresizingMaskIntoConstraints = false
        iconWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            nightTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nightTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -96),
            
            dayTempLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            dayTempLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            iconWeatherLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconWeatherLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -176)
        ])
    }
}
