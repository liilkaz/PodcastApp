//
//  SecondVC.swift
//  PodcastApp
//
//  Created by Danila Bolshakov on 25.09.2023.
//

import UIKit

final class AccountSettingViewController: UIViewController {
    
    //MARK: - Views UI
    
    private lazy var scrollViewAccountSetting: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .lightBlueColor
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var viewScreen: UIView = {
        let view = UIView()
        view.backgroundColor = .activeBlueColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var avatarImageEdit: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageAvatarView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar")
        return image
    }()
    
    private lazy var buttonEdit: UIButton = {
        let button = UIButton()
        return button
    }()
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.backgroundColor = .red
        setNavigationBarWithBackButton(title: "Profile")
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        view.addSubviews(scrollViewAccountSetting, viewScreen)
        viewScreen.addSubviews(avatarImageEdit)
        avatarImageEdit.addSubviews(imageAvatarView)
    }
}

//MARK: - Setup Constraints

extension AccountSettingViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollViewAccountSetting.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollViewAccountSetting.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollViewAccountSetting.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollViewAccountSetting.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            viewScreen.topAnchor.constraint(equalTo: scrollViewAccountSetting.topAnchor, constant: 10),
            viewScreen.leadingAnchor.constraint(equalTo: scrollViewAccountSetting.leadingAnchor, constant: 10),
            viewScreen.trailingAnchor.constraint(equalTo: scrollViewAccountSetting.trailingAnchor, constant: -10),
            viewScreen.bottomAnchor.constraint(equalTo: scrollViewAccountSetting.bottomAnchor, constant: -10),
            
            avatarImageEdit.topAnchor.constraint(equalTo: viewScreen.topAnchor, constant: 37),
            avatarImageEdit.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 138),
            avatarImageEdit.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -138),
            avatarImageEdit.heightAnchor.constraint(equalToConstant: 100),
            avatarImageEdit.widthAnchor.constraint(equalToConstant: 105),
            
            imageAvatarView.topAnchor.constraint(equalTo: avatarImageEdit.topAnchor),
            imageAvatarView.leadingAnchor.constraint(equalTo: avatarImageEdit.leadingAnchor),
            imageAvatarView.trailingAnchor.constraint(equalTo: avatarImageEdit.trailingAnchor),
            imageAvatarView.bottomAnchor.constraint(equalTo: avatarImageEdit.bottomAnchor)
        ])
    }
}

