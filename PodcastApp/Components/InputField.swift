//
//  InputField.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

class InputField: UIView {

    let inputTextField: UITextField
    let title: String

    private lazy var nameInput = UILabel(name: title, font: .jakarta14medium(), textColor: .darkGrayTextColor)


    init(inputField: UITextField, title: String) {

        self.inputTextField = inputField
        self.title = title
        super.init(frame: .zero)
        setupView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubviews(nameInput, inputTextField)
        inputTextField.layer.cornerRadius = 24
        inputTextField.setLeftPaddingPoints(16)
        inputTextField.setRightPaddingPoints(16)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameInput.topAnchor.constraint(equalTo: topAnchor),
            nameInput.leadingAnchor.constraint(equalTo: leadingAnchor),

            inputTextField.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 8),
            inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 56)
        ])
    }

}
