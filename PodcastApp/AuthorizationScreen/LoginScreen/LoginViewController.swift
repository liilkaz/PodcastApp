//
//  LoginViewController.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    let cornerRadius: CGFloat = 24
    
    private lazy var loginField = InputField(inputField: UITextField(hasBorder: false, backgroundColor: .lightGray, cornerRadius: cornerRadius, placeholder: "Enter your login"), title: "Login")

    private lazy var emailField: InputField = {
        let emailField = InputField(inputField: UITextField(hasBorder: false, backgroundColor: .lightGray, cornerRadius: cornerRadius, placeholder: "Enter your email address"), title: "Email")
        return emailField
    }()

    private lazy var emailButton: UIButton = {
        let button = UIButton(title: "Enter",
                              backgroundColor: .activeBlueColor,
                              titleColor: .white,
                              hasBorder: false,
                              cornerRadius: cornerRadius)
        return button
    }()

    private lazy var dividerView: Divider = {
        let view = Divider(title: "Or continue with")
        return view
    }()

    private lazy var googleButton: UIButton = {
        let button = UIButton(title: "  Continue with Google",
                              backgroundColor: .clear,
                              titleColor: .blackTextColor,
                              hasBorder: true,
                              cornerRadius: cornerRadius)
        button.setupGoogleImage()
        return button
    }()

    private lazy var bottomText = UILabel(text: "Don't you have an account yet?",
                            font: .jakarta16semibold(), textColor: .boldGrayTextColor)
    
    private lazy var registerButton = UIButton(title: "Register", backgroundColor: .clear, titleColor: .greenTextColor, hasBorder: false)
    
    private let bottomStackView = UIStackView(axis: .horizontal, spacing: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraint()
        navigationItem.hidesBackButton = true
    }
    
    func setupView() {
        view.backgroundColor = .white
        
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        
        bottomStackView.addArrangedSubviews(bottomText, registerButton)
        
        view.addSubviews(loginField, emailField, emailButton, dividerView, googleButton, bottomStackView)
    }
    
    func setConstraint(){
        
        NSLayoutConstraint.activate([
            loginField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            loginField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginField.heightAnchor.constraint(equalToConstant: 88),
            
            emailField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 12),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailField.heightAnchor.constraint(equalToConstant: 88),
            
            emailButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 24),
            emailButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailButton.heightAnchor.constraint(equalToConstant: 56),
            
            dividerView.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 32),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 48),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -48),
            dividerView.heightAnchor.constraint(equalToConstant: 22),
            
            googleButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 32),
            googleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            googleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            googleButton.heightAnchor.constraint(equalToConstant: 56),
            
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc
    private func didTapRegisterButton() {
        let createAcc = CreateAccountViewController()
        navigationController?.pushViewController(createAcc, animated: true)
    }
    
}
