//
//  TextFieldView.swift
//  Pods
//
//  Created by Danila Bolshakov on 02.10.2023.
//

import UIKit

enum TextFieldViewStyle {
    case firstname
    case lastname
    case email
    
    var title: String {
        switch self {
        case .firstname:
            "First Name"
        case .lastname:
            "Last Name"
        case .email:
            "E-mail"
        }
    }
}

final class TextFieldView: UIView, UITextFieldDelegate {
    //MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textFieldBackView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var universalTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter some text"
        textField.textColor = .blue
        textField.isUserInteractionEnabled = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    //MARK: - Private Properties
    private var style: TextFieldViewStyle?
    
    //MARK: - Lifecycle Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    convenience init(style: TextFieldViewStyle) {
        self.init()
        self.style = style
        setupUI()
    }
}

//MARK: - SetupUI & Layout
private extension  TextFieldView {
    func setupUI() {
        addSubview(titleLabel)
        addSubview(textFieldBackView)
        textFieldBackView.addSubview(universalTextField)
        setupConstraints()
        
        titleLabel.text = style?.title
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            textFieldBackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            textFieldBackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            textFieldBackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            universalTextField.topAnchor.constraint(equalTo: textFieldBackView.topAnchor, constant: 14),
            universalTextField.leadingAnchor.constraint(equalTo: textFieldBackView.leadingAnchor, constant: 16),
            universalTextField.trailingAnchor.constraint(equalTo: textFieldBackView.trailingAnchor, constant: -16),
            universalTextField.bottomAnchor.constraint(equalTo: textFieldBackView.bottomAnchor, constant: -14)
        ])
    }
}

    let firstName = TextFieldView(style: .firstname)
    let lastName = TextFieldView(style: .lastname)
    let email = TextFieldView(style: .email)
