//
//  SignUpViewController.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let cornerRadius: CGFloat = 24
    
    private lazy var titleLabel = UILabel(text: "Complet your account",
                            font: .jakarta24(), textColor: .blackTextColor)

    private lazy var subTitleLabel = UILabel(text: "Lorem ipsum dolor sit amet", font: .jakarta14medium(), textColor: .darkGrayTextColor)
    
    private lazy var firstNameField = InputField(inputField: UITextField(hasBorder: false,
                                                                backgroundColor: .lightGray,
                                                                cornerRadius: cornerRadius,
                                                                placeholder: "Enter your first name"),
                                        title: "First Name")

    private lazy var lastNameField = InputField(inputField: UITextField(hasBorder: false,
                                                               backgroundColor: .lightGray,
                                                               cornerRadius: cornerRadius,
                                                               placeholder: "Enter your last name"), title: "Last Name")
    
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
    
    private lazy var signUpButton = UIButton(title: "Sign Up", backgroundColor: .activeBlueColor, titleColor: .white, hasBorder: false, cornerRadius: cornerRadius)
    
    
    // вынести в компоненты
    private lazy var bottomText = UILabel(text: "Already hav an account?",
                            font: .jakarta16semibold(), textColor: .boldGrayTextColor)

    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .jakarta16semibold()
        button.setTitleColor(.purpleTextColor, for: .normal)
        button.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarBackButtonAuth(title: "Sign Up")
        setupView()
        setConstraints()
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
    }
    
    func setupView() {
        view.backgroundColor = .white
        
        bottomStackView.addArrangedSubview(bottomText)
        bottomStackView.addArrangedSubview(loginButton)
        
        mainStackView.addArrangedSubview(firstNameField)
        mainStackView.addArrangedSubview(lastNameField)
        mainStackView.addArrangedSubview(emailField)
        mainStackView.addArrangedSubview(passwordField)
        mainStackView.addArrangedSubview(confirmPasswordField)
        
        view.addSubviews(titleLabel, subTitleLabel, mainStackView, signUpButton, bottomStackView)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            mainStackView.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -24),
            
            signUpButton.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -24),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            signUpButton.heightAnchor.constraint(equalToConstant: 56),
            
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            bottomStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
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
    
    // MARK: - @objs Methods
    
    @objc
    private func didTapLoginButton() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @objc
    private func didTapSignUp() {
        AuthService.shared.register(
            email: emailField.inputTextField.text,
            password: passwordField.inputTextField.text,
            confirmPassword: confirmPasswordField.inputTextField.text) { [weak self] result in
                switch result {
                case .success(let user):
                    let homeVC = TabBarViewController()
                    homeVC.modalPresentationStyle = .fullScreen
                    self?.present(homeVC, animated: true)
                    print(user)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
    }
    
}
