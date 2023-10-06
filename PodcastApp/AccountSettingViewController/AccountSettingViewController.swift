//
//  SecondVC.swift
//  PodcastApp
//
//  Created by Danila Bolshakov on 25.09.2023.
//

import UIKit

final class AccountSettingViewController: UIViewController {
    
    //MARK: - User Interface
    
    private lazy var scrollViewAccountSetting: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .white
        scroll.contentSize = contentCGSize
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
        view.backgroundColor = .white
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
#warning("button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)")
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    private lazy var genderLabel = UILabel(
        text: "Gender",
        font: .jakarta14medium(),
        textColor: .darkGrayTextColor,
        textAlignment: .left
    )
    
    lazy var checkBoxButtonOne: UIButton = {
        let button = UIButton()
        button.setTitle("Male", for: .normal)
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        configuration.image = UIImage(systemName: "circle")
        configuration.imagePadding = 8
        configuration.imagePlacement = .leading
        button.configuration = configuration
        return button
    }()
    
    lazy var checkBoxButtonTwo: UIButton = {
        let button = UIButton()
        button.setTitle("Famale", for: .normal)
        var configuration = UIButton.Configuration.filled()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)
        configuration.image = UIImage(systemName: "circle")
        configuration.imagePadding = 8
        configuration.imagePlacement = .leading
        button.configuration = configuration
        button.backgroundColor = .clear
        return button
    }()
    
    private lazy var checkboxSwitchStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.spacing = 16
        stack.axis = .horizontal
        return stack
    }()
    
    let buttonSaveChanges = UIButton(
        title: "Save Changes",
        backgroundColor: .lightGray,
        titleColor: .darkGray,
        font: .jakarta16(),
        hasBorder: false,
        cornerRadius: 20
    )
    
    private var contentCGSize: CGSize {
        CGSize(width: view.frame.width, height: view.frame.height + 1000)
    }
    
    @IBAction private func genderPressed(_ sender: UIButton) {
        checkBoxButtonOne.setImage(UIImage(systemName: "circle"), for: .normal)
        checkBoxButtonTwo.setImage(UIImage(systemName: "circle"), for: .normal)
        sender.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        saveAddTarget()
        setupConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.backgroundColor = .white
        setNavigationBarBackButtonAuth(title: "Profile")
    }
    
    private func saveAddTarget() {
        dateOfBirth.inputTextField.setupRightButton(with: UIImage(named: "calendar")!)
        buttonEdit.addTarget(self, action: #selector(imageTapped(_:)), for: .touchUpInside)
        checkBoxButtonOne.addTarget(self, action: #selector(genderPressed(_:)), for: .touchUpInside)
        checkBoxButtonTwo.addTarget(self, action: #selector(genderPressed(_:)), for: .touchUpInside)
        buttonSaveChanges.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
    }
    
    //MARK: - Setup Views
    
    private func setupViews() {
        view.addSubviews(scrollViewAccountSetting)
        scrollViewAccountSetting.addSubviews(viewScreen)
        viewScreen.addSubviews(avatarImageEdit, firstName, lastName, email, dateOfBirth, genderLabel, checkboxSwitchStack, buttonSaveChanges)
        avatarImageEdit.addSubviews(imageAvatarView, buttonEdit)
        checkboxSwitchStack.addArrangedSubviews(checkBoxButtonOne, checkBoxButtonTwo)
    }
    
    //MARK: - @objc private func
    
    @objc private func editButtonTapped() {
        print("Edit button pressed")
    }
    
    @objc private func saveChanges() {
        print("Save Changes")
    }
}

extension AccountSettingViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @objc private func imageTapped(_ sender: UIImageView) {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubviews(blurView)
        let imagePicker = UIImagePickerController()
        
        UIView.animate(
            withDuration: 1.0) {
                blurView.alpha = 1.0
            } completion: { _ in
                imagePicker.delegate = self
            }
        
        let alertController = UIAlertController(title: "Change your picture", message: nil, preferredStyle: .actionSheet)
        let alertOff = CustomAlertController()
        alertOff.modalPresentationStyle = .overFullScreen
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Take a photo", style: .default) { _ in
                UIView.animate(withDuration: 0.3) {
                    blurView.alpha = 0.0
                }
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true)
            }
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Choose from your file", style: .default) { _ in
                UIView.animate(withDuration: 0.3) {
                    blurView.alpha = 0.0
                }
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true)
            }
            alertController.addAction(photoLibraryAction)
        }
        
        alertController.popoverPresentationController?.sourceView = sender
        present(alertController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageAvatarView.image = image
            imageAvatarView.layer.cornerRadius = imageAvatarView.frame.size.width / 2
            imageAvatarView.clipsToBounds = true
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITextFieldDelegate

extension AccountSettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != nil {
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
            scrollViewAccountSetting.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            viewScreen.topAnchor.constraint(equalTo: scrollViewAccountSetting.topAnchor),
            viewScreen.leadingAnchor.constraint(equalTo: scrollViewAccountSetting.leadingAnchor),
            viewScreen.trailingAnchor.constraint(equalTo: scrollViewAccountSetting.trailingAnchor),
            viewScreen.bottomAnchor.constraint(equalTo: scrollViewAccountSetting.bottomAnchor),
            viewScreen.heightAnchor.constraint(equalTo: view.heightAnchor),
            viewScreen.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            avatarImageEdit.topAnchor.constraint(equalTo: viewScreen.topAnchor, constant: 37),
            avatarImageEdit.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 138),
            avatarImageEdit.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -138),
            avatarImageEdit.heightAnchor.constraint(equalToConstant: 100),
            
            imageAvatarView.topAnchor.constraint(equalTo: avatarImageEdit.topAnchor),
            imageAvatarView.centerXAnchor.constraint(equalTo: avatarImageEdit.centerXAnchor),
            imageAvatarView.heightAnchor.constraint(equalToConstant: 100),
            imageAvatarView.widthAnchor.constraint(equalToConstant: 100),
            
            buttonEdit.topAnchor.constraint(equalTo: avatarImageEdit.topAnchor, constant: 68),
            buttonEdit.leadingAnchor.constraint(equalTo: avatarImageEdit.leadingAnchor, constant: 73),
            buttonEdit.trailingAnchor.constraint(equalTo: avatarImageEdit.trailingAnchor, constant: 5),
            buttonEdit.heightAnchor.constraint(equalToConstant: 50),
            
            firstName.topAnchor.constraint(equalTo: avatarImageEdit.bottomAnchor, constant: 16),
            firstName.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            firstName.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            
            lastName.topAnchor.constraint(equalTo: firstName.bottomAnchor, constant: 16),
            lastName.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            lastName.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            
            email.topAnchor.constraint(equalTo: lastName.bottomAnchor, constant: 16),
            email.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            email.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            
            dateOfBirth.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 16),
            dateOfBirth.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            dateOfBirth.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            
            genderLabel.topAnchor.constraint(equalTo: dateOfBirth.bottomAnchor, constant: 16),
            genderLabel.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            genderLabel.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            
            checkboxSwitchStack.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            checkboxSwitchStack.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            checkboxSwitchStack.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            
            buttonSaveChanges.leadingAnchor.constraint(equalTo: viewScreen.leadingAnchor, constant: 32),
            buttonSaveChanges.trailingAnchor.constraint(equalTo: viewScreen.trailingAnchor, constant: -32),
            buttonSaveChanges.bottomAnchor.constraint(equalTo: viewScreen.bottomAnchor, constant: -20),
            buttonSaveChanges.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
