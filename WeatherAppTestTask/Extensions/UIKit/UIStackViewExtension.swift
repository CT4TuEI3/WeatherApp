//
//  UIStackViewExtension.swift
//  WeatherAppTestTask
//
//  Created by Алексей on 30.05.2023.
//

import UIKit

extension UIStackView {
    /// Добавить несколько Вью в стек
    /// - Parameter views: Вьюхи
    func addArrangedSubviews(_ views: [UIView?]) {
        views.forEach {
            guard let subview = $0 else { return }
            addArrangedSubview(subview)
        }
    }
}
