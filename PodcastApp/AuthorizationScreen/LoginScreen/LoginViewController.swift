//
//  LoginViewController.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit
import Firebase
import GoogleSignIn
import FirebaseAuth
import GoogleSignInSwift

class LoginViewController: UIViewController {
    
    let cornerRadius: CGFloat = 24
    
    private lazy var emailField = InputField(inputField: UITextField(hasBorder: false, backgroundColor: .lightGray, cornerRadius: cornerRadius, placeholder: "Enter your email address"), title: "Email")

    private lazy var passwordField = InputField(inputField: UITextField(hasBorder: false, backgroundColor: .lightGray, cornerRadius: cornerRadius, placeholder: "Enter your password"), title: "Password")

    private lazy var loginButton: UIButton = {
        let button = UIButton(title: "Login",
                              backgroundColor: .activeBlueColor,
                              titleColor: .white,
                              hasBorder: false,
                              cornerRadius: cornerRadius)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
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
        
        view.addSubviews(emailField, passwordField, loginButton, dividerView, googleButton, bottomStackView)
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
            
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 56),
            
            dividerView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 32),
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
    private func didTapLoginButton() {
        AuthService.shared.login(email: emailField.inputTextField.text,
                                 password: passwordField.inputTextField.text) { [weak self] result in
            switch result {
            case .success(let user):
                let homeVC = TabBarViewController()
                homeVC.modalPresentationStyle = .fullScreen
                self?.present(homeVC, animated: true)
                print(user)
            case .failure(let error):
                self?.showAlert(with: "Ошибка", and: error.localizedDescription)
            }
        }
    }
    
    @objc
    private func didTapGoogleButton() {
       signWithGoogle()
    }
}

extension LoginViewController {
    private func signWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
              showAlert(with: "Warning!", and: AuthError.unknownError.localizedDescription)
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
              return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { [weak self] result, error in

                if result != nil {
                    let homeVC = TabBarViewController()
                    homeVC.modalPresentationStyle = .fullScreen
                    self?.present(homeVC, animated: true)
                }

                if error != nil {
                    self?.showAlert(with: "Warning", and: AuthError.unknownError.localizedDescription)
                }
            }
        }
    }
}
