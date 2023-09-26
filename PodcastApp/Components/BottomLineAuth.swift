//
//  BottomLineAuth.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 26.09.2023.
//

import UIKit

// пока не работает, подумать над констреинтами

class BottomLineAuth: UIView {
    
    var text: String
    var title: String
    var action: Selector
    
    init(text: String, title: String, action: Selector) {
        self.text = text
        self.title = title
        self.action = action
        super.init(frame: .zero)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var bottomText = UILabel(name: text, font: .jakarta16semibold(), textColor: .boldGrayTextColor)
    
    private lazy var loginButton = UIButton(title: title, backgroundColor: .clear, titleColor: .purpleTextColor, hasBorder: false)
    
    private let bottomStackView = UIStackView(axis: .horizontal, spacing: 1)

    private func setupView() {
        bottomStackView.addArrangedSubviews(bottomText, loginButton)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([

        ])
    }
    
}
