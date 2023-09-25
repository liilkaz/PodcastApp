//
//  LoginView.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

final class CreateAccount: UIView {
    
    let cornerRadius: CGFloat = 24

    private let titleLabel: UILabel = {
        let label = UILabel(name: "Create account", font: .jakarta24())
        label.textColor = .white
        return label
    }()

    private lazy var subTitleLabel: UILabel = {
        let label = UILabel(name: "Lorem ipsum dolor sit amet", font: .jakarta16())
        label.textColor = .white
        return label
    }()

    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private lazy var emailField: InputField = {
        let emailField = InputField(inputField: UITextField(hasBorder: false, backgroundColor: .lightGray, cornerRadius: cornerRadius, placeholder: "Enter your email address"), title: "Email")
        return emailField
    }()

    private lazy var emailButton: UIButton = {
        let button = UIButton(title: "Continue with Email",
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .activeBlueColor
        mainView.layer.cornerRadius = 32
        mainView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        addSubviews(titleLabel, subTitleLabel, mainView)
        
        bottomStackView.addArrangedSubview(bottomText)
        bottomStackView.addArrangedSubview(loginButton)
        
        mainView.addSubviews(emailField, emailButton, dividerView, googleButton, bottomStackView)
    }
    
    func setConstraint(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            mainView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 48),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 48),
            emailField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            emailField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            emailField.heightAnchor.constraint(equalToConstant: 88),
            
            emailButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 32),
            emailButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            emailButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            emailButton.heightAnchor.constraint(equalToConstant: 56),
            
            dividerView.topAnchor.constraint(equalTo: emailButton.bottomAnchor, constant: 32),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48),
            dividerView.heightAnchor.constraint(equalToConstant: 22),
            
            googleButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 32),
            googleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            googleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            googleButton.heightAnchor.constraint(equalToConstant: 56),
            
            bottomStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -90),
            bottomStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
