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
        view.backgroundColor = .white
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
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var buttonEdit: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "edit")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - TextFieldView
    
    private lazy var firstName = InputField(
        inputField: UITextField(
            hasBorder: false,
            backgroundColor: .lightGray,
            cornerRadius: 10,
            placeholder: "Enter somthing"),
        title: "First Name"
    )
    
    private lazy var lastName = InputField(
        inputField: UITextField(
            hasBorder: false,
            backgroundColor: .lightGray,
            cornerRadius: 10,
            placeholder: "Enter somthing"),
        title: "Last Name"
    )
    
    private lazy var email = InputField(
        inputField: UITextField(
            hasBorder: false,
            backgroundColor: .lightGray,
            cornerRadius: 10,
            placeholder: "Enter somthing"),
        title: "E-mail"
    )
    
    private lazy var dateOfBirth = InputField(
        inputField: UITextField(
            hasBorder: false,
            backgroundColor: .lightGray,
            cornerRadius: 10,
            placeholder: "Enter somthing"),
        title: "Date of Birth"
    )
    
    private lazy var buttonSaveChanges = UIButton(title: "Save Changes", backgroundColor: .gray, titleColor: .darkGray, hasBorder: true)
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.backgroundColor = .white
        setNavigationBarWithBackButton(title: "Profile")
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        view.addSubviews(scrollViewAccountSetting, viewScreen)
        viewScreen.addSubviews(avatarImageEdit, firstName, lastName, email, dateOfBirth, buttonSaveChanges)
        dateOfBirth.inputTextField.setupRightButton(with: UIImage(named: "calendar")!)
        avatarImageEdit.addSubviews(imageAvatarView, buttonEdit)
    }
    
    //MARK: - @objc private func editButtonTapped()
    
    @objc private func editButtonTapped() {
        print("Edit button pressed")
    }
}

extension AccountSettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            print("Print TextField")
        }
   }
}

//MARK: - Setup Constraints

extension AccountSettingViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollViewAccountSetting.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollViewAccountSetting.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollViewAccountSetting.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollViewAccountSetting.heightAnchor.constraint(equalToConstant: 2000),
            
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
            imageAvatarView.bottomAnchor.constraint(equalTo: avatarImageEdit.bottomAnchor),
            
            buttonEdit.topAnchor.constraint(equalTo: avatarImageEdit.topAnchor, constant: 68),
            buttonEdit.leadingAnchor.constraint(equalTo: avatarImageEdit.leadingAnchor, constant: 73),
            buttonEdit.trailingAnchor.constraint(equalTo: avatarImageEdit.trailingAnchor, constant: 5),
            buttonEdit.heightAnchor.constraint(equalToConstant: 32),
            buttonEdit.widthAnchor.constraint(equalToConstant: 32),
            
            firstName.topAnchor.constraint(equalTo: avatarImageEdit.bottomAnchor, constant: 16),
            firstName.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            firstName.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            
            lastName.topAnchor.constraint(equalTo: avatarImageEdit.bottomAnchor, constant: 114),
            lastName.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            lastName.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            
            email.topAnchor.constraint(equalTo: avatarImageEdit.bottomAnchor, constant: 212),
            email.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            email.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            
            dateOfBirth.topAnchor.constraint(equalTo: avatarImageEdit.bottomAnchor, constant: 310),
            dateOfBirth.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            dateOfBirth.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            
            buttonEdit.topAnchor.constraint(equalTo: avatarImageEdit.bottomAnchor, constant: 728),
            buttonEdit.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            buttonEdit.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            buttonEdit.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

