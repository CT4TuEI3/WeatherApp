//
//  UIViewExtension.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 30.05.2023.
//

import UIKit

extension UIView {
    /// Функция для добавления нескольких views на одну view.
    ///  Внутри функции выполняется проверка на nil
    func addSubviews(_ views: [UIView?]) {
        views.forEach {
            guard let subview = $0 else { return }
            addSubview(subview)
        }
    }
}
