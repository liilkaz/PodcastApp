//
//  UILabel + Extension.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

extension UILabel {
    convenience init(name: String, font: UIFont? = .jakarta16(), textColor: UIColor) {
        self.init()
        self.text = name
        self.font = font
        self.textColor = textColor
    }
}
