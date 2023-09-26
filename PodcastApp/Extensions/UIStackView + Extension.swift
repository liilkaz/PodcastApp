//
//  UIStackView + Extension.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 26.09.2023.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init()
        self.axis = axis
        self.spacing = spacing
    }
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        })
    }
}
