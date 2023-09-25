//
//  SignUp.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

class SignUp: UIView {

    let cornerRadius: CGFloat = 24
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(name: "Complet your account",
                            font: .jakarta24())
        label.textColor = .blackTextColor
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel(name: "Lorem ipsum dolor sit amet", font: .jakarta14medium())
        label.textColor = .darkGrayTextColor
        return label
    }()
    
    private lazy var firstNameField: InputField = {
        let firstNameField = InputField(inputField: UITextField(hasBorder: false,
                                                                backgroundColor: .lightGray,
                                                                cornerRadius: cornerRadius,
                                                                placeholder: "Enter your first name"),
                                        title: "First Name")
        return firstNameField
    }()
    
    private lazy var lastNameField: InputField = {
        let lastNameField = InputField(inputField: UITextField(hasBorder: false,
                                                               backgroundColor: .lightGray,
                                                               cornerRadius: cornerRadius,
                                                               placeholder: "Enter your last name"), title: "Last Name")
        return lastNameField
    }()
    
    private lazy var emailField: InputField = {
        let emailField = InputField(inputField: UITextField(hasBorder: false,
                                                            backgroundColor: .lightGray,
                                                            cornerRadius: cornerRadius,
                                                            placeholder: "Enter your email"), title: "E-mail")
        emailField.inputTextField.keyboardType = .emailAddress
        return emailField
    }()
    
    private lazy var showHidePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("     ", for: .normal)
        button.tintColor = .lightGrayTextColor
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                button.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var showHideConfirmPasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("     ", for: .normal)
        button.tintColor = .lightGrayTextColor
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
                button.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var passwordField: InputField = {
        let passwordField = InputField(inputField: UITextField(hasBorder: false,
                                                               backgroundColor: .lightGray,
                                                               cornerRadius: cornerRadius,
                                                               placeholder: "Enter your password"), title: "Password")
        passwordField.inputTextField.isSecureTextEntry = true
        passwordField.inputTextField.rightView = showHidePasswordButton
        passwordField.inputTextField.rightViewMode = .always
        return passwordField
    }()
    
    private lazy var confirmPasswordField: InputField = {
        let confirmPasswordField = InputField(inputField: UITextField(hasBorder: false,
                                                                      backgroundColor: .lightGray,
                                                                      cornerRadius: cornerRadius,
                                                                      placeholder: "Confirm your password"), title: "Confirm Password")
        confirmPasswordField.inputTextField.isSecureTextEntry = true
        confirmPasswordField.inputTextField.rightView = showHideConfirmPasswordButton
        confirmPasswordField.inputTextField.rightViewMode = .always
        return confirmPasswordField
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(title: "Sign Up", backgroundColor: .activeBlueColor, titleColor: .white, hasBorder: false, cornerRadius: cornerRadius)
        return button
    }()
    
    
    // вынести в компоненты
    private lazy var bottomText: UILabel = {
        let label = UILabel(name: "Already hav an account?",
                            font: .jakarta16semibold())
        label.textColor = .boldGrayTextColor
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .jakarta16semibold()
        button.setTitleColor(.purpleTextColor, for: .normal)
        return button
    }()
    
    let bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    //
    
    let mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .white
        
        bottomStackView.addArrangedSubview(bottomText)
        bottomStackView.addArrangedSubview(loginButton)
        
        mainStackView.addArrangedSubview(firstNameField)
        mainStackView.addArrangedSubview(lastNameField)
        mainStackView.addArrangedSubview(emailField)
        mainStackView.addArrangedSubview(passwordField)
        mainStackView.addArrangedSubview(confirmPasswordField)
        
        addSubviews(titleLabel, subTitleLabel, mainStackView, signUpButton, bottomStackView)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            mainStackView.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -24),
            
            signUpButton.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -24),
            signUpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            signUpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            signUpButton.heightAnchor.constraint(equalToConstant: 56),
            
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24),
            bottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    @objc
    private func showHideButtonTapped(sender: UIButton) {
        if sender == showHidePasswordButton {
            passwordField.inputTextField.isSecureTextEntry.toggle()

        passwordField.inputTextField.isSecureTextEntry ?
                    showHidePasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal) : showHidePasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
        else {
            confirmPasswordField.inputTextField.isSecureTextEntry.toggle()
            confirmPasswordField.inputTextField.isSecureTextEntry ?
            showHideConfirmPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal) : showHideConfirmPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        }
    }
}
