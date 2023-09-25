//
//  CreateAccountViewController.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 25.09.2023.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    let createAccount = CreateAccount()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(createAccount)
        NSLayoutConstraint.activate([
            createAccount.topAnchor.constraint(equalTo: view.topAnchor),
            createAccount.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            createAccount.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            createAccount.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }


}
