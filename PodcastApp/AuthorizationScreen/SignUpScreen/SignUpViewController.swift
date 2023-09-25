//
//  SignUpViewController.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

class SignUpViewController: UIViewController {
    
    let signUp = SignUp()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        view.addSubviews(signUp)
        NSLayoutConstraint.activate([
            signUp.topAnchor.constraint(equalTo: view.topAnchor),
            signUp.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUp.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signUp.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    private func setNavigationBar() {
        title = "Sign Up"
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(
            image: UIImage(named: "arrowBack")?.withTintColor(.systemGray,
                                                              renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc
    private func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
