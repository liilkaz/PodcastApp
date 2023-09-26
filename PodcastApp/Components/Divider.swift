//
//  Divider.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

final class Divider: UIView {
    
    var title: String
    
    private lazy var leftSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .boldGrayTextColor
        return view
    }()
    
    private lazy var rightSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .boldGrayTextColor
        return view
    }()
    
    private lazy var titleLabel = UILabel(name: title, font: .jakarta14(), textColor: .boldGrayTextColor)
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubviews(leftSeparatorView, titleLabel, rightSeparatorView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            leftSeparatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftSeparatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            
            titleLabel.leadingAnchor.constraint(equalTo: leftSeparatorView.trailingAnchor, constant: 12),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            rightSeparatorView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12),
            rightSeparatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            rightSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
