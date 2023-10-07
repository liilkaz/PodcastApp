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
        let email = emailField.inputTextField.text
        let password = passwordField.inputTextField.text
        AuthService.shared.login(email: email,
                                 password: password) { [weak self] result in
            switch result {
            case .success(let user):
                let safeEmail = DatabaseManager.safeEmail(emailAddress: email ?? "none")
                DatabaseManager.shared.getDataFor(path: safeEmail) { result in
                    switch result {
                    case .success(let data):
                        guard let userData = data as? [String: Any],
                              let firstName = userData["first_name"] as? String,
                              let lastName = userData["last_name"] as? String else {
                            return
                        }
                        UserDefaults.standard.set("\(firstName) \(lastName)", forKey: "name")
                        
                    case .failure(let error):
                        print("Failed to read data with error \(error)")
                    }
                }
                let homeVC = TabBarViewController()
                homeVC.modalPresentationStyle = .fullScreen
                self?.present(homeVC, animated: true)
                UserDefaults.standard.set(email, forKey: "email")
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
            else { return }
            
            guard let email = user.profile?.email,
                  let firstName = user.profile?.givenName,
                  let lastName = user.profile?.familyName else { return }
            UserDefaults.standard.set(email, forKey: "email")
            
            DatabaseManager.shared.userExists(with: email) { exists in
                if !exists {
                    let userInfo = UserDataBase(firstName: firstName, lastName: lastName, email: email)
                    DatabaseManager.shared.insertUser(with: userInfo, completion: {
                        success in
                        if success {
                            if ((user.profile?.hasImage) != nil) {
                                guard let url = user.profile?.imageURL(withDimension: 100) else {
                                    return
                                }
                                URLSession.shared.dataTask(with: url) { data, _, _ in
                                    guard let data = data else {
                                        return
                                    }
                                    let filename = userInfo.profilePictureFileName
                                    StorageManager.shared.uploadProfilePicture(with: data, fileName: filename) { result in
                                        switch result {
                                        case .success(let downloadURL):
                                            UserDefaults.standard.set(downloadURL, forKey: "profile_picture_file_name")
                                            print(downloadURL)
                                        case .failure(let error):
                                            print(error)
                                        }
                                    }
                                }.resume()
                            }
                        }
                    })
                }
            }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { [weak self] result, error in
                
                if result != nil {
                    let safeEmail = DatabaseManager.safeEmail(emailAddress: email)
                    DatabaseManager.shared.getDataFor(path: safeEmail) { result in
                        switch result {
                        case .success(let data):
                            guard let userData = data as? [String: Any],
                                  let firstName = userData["first_name"] as? String,
                                  let lastName = userData["last_name"] as? String else {
                                return
                            }
                            UserDefaults.standard.set("\(firstName) \(lastName)", forKey: "name")
                            
                        case .failure(let error):
                            print("Failed to read data with error \(error)")
                        }
                    }
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
