//
//  AccountSettingViewController.swift
//  PodcastApp
//
//  Created by iOS - Developer on 02.10.2023.
//

import UIKit

final class AccountSettingViewController: UIViewController {
    
    //MARK: - Private Properties UI
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = .white
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setNavigationBarWithBackButton(title: "Profile")
    }
}


