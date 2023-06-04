//
//  UIViewControllerExtension.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 29.05.2023.
//

import UIKit

extension UIViewController {
    /// Показывает алерт с ошибкой
    /// - Parameter message: Сообщение ошибки
    func showSystemErrorAlert(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Упс! Что-то пошло не так...",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Хорошо",
                                          style: .destructive))
            self.present(alert, animated: true)
        }
    }
}
