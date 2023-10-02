//
//  UILabel + Extension.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

extension UILabel {
    convenience init(text: String = "", font: UIFont? = .jakarta16(), textColor: UIColor, textAlignment: NSTextAlignment = .center, numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
