//
//  CreateAccountViewController.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    let cornerRadius: CGFloat = 24

    private lazy var titleLabel = UILabel(text: "Create account", font: .jakarta24(), textColor: .white)

    private lazy var subTitleLabel = UILabel(text: "Lorem ipsum dolor sit amet", font: .jakarta16(), textColor: .white)

    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var emailField = InputField(inputField: UITextField(hasBorder: false, backgroundColor: .lightGray, cornerRadius: cornerRadius, placeholder: "Enter your email address"), title: "Email")


    private lazy var emailButton = UIButton(title: "Continue with Email",
                              backgroundColor: .activeBlueColor,
                              titleColor: .white,
                              hasBorder: false,
                              cornerRadius: cornerRadius)

    private lazy var dividerView = Divider(title: "Or continue with")

    private lazy var googleButton: UIButton = {
        let button = UIButton(title: "  Continue with Google",
                              backgroundColor: .clear,
                              titleColor: .blackTextColor,
                              hasBorder: true,
                              cornerRadius: cornerRadius)
        button.setupGoogleImage()
        return button
    }()

    private let bottomText = UILabel(text: "Already have an account?",
                            font: .jakarta16semibold(), textColor: .boldGrayTextColor)
    
    private lazy var loginButton = UIButton(title: "Login", backgroundColor: .clear, titleColor: .purpleTextColor, hasBorder: false)
    
    private let bottomStackView = UIStackView(axis: .horizontal, spacing: 2)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        navigationItem.hidesBackButton = true
    }
    
    private func setupView() {
        view.backgroundColor = .activeBlueColor
        mainView.layer.cornerRadius = 32
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        
        view.addSubviews(titleLabel, subTitleLabel, mainView)
        
        bottomStackView.addArrangedSubviews(bottomText, loginButton)
        
        emailButton.addTarget(self, action: #selector(didTapEmailButton), for: .touchUpInside)
        
        mainView.addSubviews(emailField, emailButton, dividerView, googleButton, bottomStackView)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 48),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 48),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailField.heightAnchor.constraint(equalToConstant: 88),
            
            emailButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 32),
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

    // MARK: - @objs Methods

    @objc
    private func didTapEmailButton() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }

    @objc
    private func didTapLoginButton() {
        navigationController?.popViewController(animated: true)
    }

}
