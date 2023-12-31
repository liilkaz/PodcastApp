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
    
    func showAlert(with title: String, and message: String, completion: @escaping () -> Void = { }) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            completion()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}


