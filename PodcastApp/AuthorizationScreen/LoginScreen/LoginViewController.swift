//
//  LoginViewController.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    let cornerRadius: CGFloat = 24
    
    private lazy var emailField = InputField(inputField: UITextField(hasBorder: false, backgroundColor: .lightGray, cornerRadius: cornerRadius, placeholder: "Enter your email address"), title: "Email")

    private lazy var passwordField: InputField = {
        let emailField = InputField(inputField: UITextField(hasBorder: false, backgroundColor: .lightGray, cornerRadius: cornerRadius, placeholder: "Enter your password"), title: "Password")
        return emailField
    }()

    private lazy var EnterButton: UIButton = {
        let button = UIButton(title: "Enter",
                              backgroundColor: .activeBlueColor,
                              titleColor: .white,
                              hasBorder: false,
                              cornerRadius: cornerRadius)
        button.addTarget(self, action: #selector(didTapEnterButton), for: .touchUpInside)
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

    private lazy var bottomText = UILabel(name: "Don't you have an account yet?",
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
        
        view.addSubviews(emailField, passwordField, EnterButton, dividerView, googleButton, bottomStackView)
    }
    
    func setConstraint(){
        
        NSLayoutConstraint.activate([
            emailField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            emailField.heightAnchor.constraint(equalToConstant: 88),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            passwordField.heightAnchor.constraint(equalToConstant: 88),
            
            EnterButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24),
            EnterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            EnterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            EnterButton.heightAnchor.constraint(equalToConstant: 56),
            
            dividerView.topAnchor.constraint(equalTo: EnterButton.bottomAnchor, constant: 32),
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
    
    @objc
    private func didTapEnterButton() {
        AuthService.shared.login(email: emailField.inputTextField.text,
                                 password: passwordField.inputTextField.text) { [weak self] result in
            switch result {
            case .success(let user):
//                if self?.userDataService.getUser(for: user.uid) == nil {
//                    let userModel = UserModel(
//                        email: user.email ?? "no",
//                        firstName: user.displayName ?? "no",
//                        lastName: "no",
//                        uuid: user.uid)
//                    self?.userDataService.saveUserModel(with: userModel)
//                    AllMovies.shared.userId = userModel.uuid
//                } else {
//                    AllMovies.shared.userId = user.uid
//                }

                let homeVC = TabBarViewController()
                homeVC.modalPresentationStyle = .fullScreen
                self?.present(homeVC, animated: true)
                print(user)
            case .failure(let error):
//                self?.showAlert(with: "Ошибка", and:
                print(error.localizedDescription)
            }
        }
    }
    
}
