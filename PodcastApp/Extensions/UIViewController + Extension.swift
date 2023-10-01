//
//  UIViewController + Extension.swift
//  PodcastApp
//
//  Created by Лилия Феодотова on 26.09.2023.
//

import UIKit

extension UIViewController {
    func setNavigationBarBackButtonAuth(title: String) {
        navigationItem.hidesBackButton = true
        navigationItem.title = title
        let backButton = UIBarButtonItem(
            image: UIImage(named: "arrowBack")?.withTintColor(.blackTextColor,
                                                              renderingMode: .alwaysOriginal), style: .plain, target: self, action: #selector(goBack))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func setNavigationBarWithBackButton(title: String) {
        navigationItem.hidesBackButton = true
        navigationItem.title = title
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .blackTextColor
        navigationItem.leftBarButtonItem = backButton
        
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}


extension UIViewController {
    func setupNavigationBarWithBackButton(title: String) {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(goBackVC))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = title
    }
    @IBAction private func goBackVC() {
        navigationController?.popViewController(animated: true)
    }
}
