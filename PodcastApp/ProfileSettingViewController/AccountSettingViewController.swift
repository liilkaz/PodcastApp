//
//  AccountSettingViewController.swift
//  PodcastApp
//
//  Created by iOS - Developer on 02.10.2023.
//

import UIKit

final class AccountSettingViewController: UIViewController {
    
    //MARK: - Private Properties UI
    
    private lazy var scrollAccountSetting: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var viewPresent: UIView = {
        let view = UIView()
        view.backgroundColor = .activeBlueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackAccountSetting: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .boldGrayTextColor
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var viewAvatarEdit: UIView = {
        let avatar = UIView()
        avatar.translatesAutoresizingMaskIntoConstraints = false
        return avatar
    }()
    
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        setViews()
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setNavigationBarWithBackButton(title: "Profile")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: - Setup Views
    
    private func setViews() {
        view.addSubviews(scrollAccountSetting, viewPresent, stackAccountSetting)
        view.backgroundColor = .white
    }
}

//MARK: - Setup Constraints

extension AccountSettingViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollAccountSetting.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollAccountSetting.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            scrollAccountSetting.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            scrollAccountSetting.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollAccountSetting.heightAnchor.constraint(equalToConstant: 2000),
            
            viewPresent.topAnchor.constraint(equalTo: scrollAccountSetting.topAnchor, constant: 37),
            viewPresent.leadingAnchor.constraint(equalTo: scrollAccountSetting.leadingAnchor),
            viewPresent.trailingAnchor.constraint(equalTo: scrollAccountSetting.trailingAnchor),
            viewPresent.bottomAnchor.constraint(equalTo: scrollAccountSetting.bottomAnchor),
            viewPresent.heightAnchor.constraint(equalToConstant: 2000),
            
            stackAccountSetting.topAnchor.constraint(equalTo: viewPresent.topAnchor, constant: 10),
            stackAccountSetting.leadingAnchor.constraint(equalTo: viewPresent.leadingAnchor, constant: 10),
            stackAccountSetting.trailingAnchor.constraint(equalTo: viewPresent.trailingAnchor, constant: -10),
            stackAccountSetting.bottomAnchor.constraint(equalTo: viewPresent.bottomAnchor, constant: -10)
        ])
    }
}
