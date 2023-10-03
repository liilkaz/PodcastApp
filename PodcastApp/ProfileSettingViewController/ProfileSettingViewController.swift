
//
//  PSViewController.swift
//  PodcastApp
//
//  Created by Danila Bolshakov on 25.09.2023.
//

import UIKit

struct Theme {
    static let psVCTableViewCellID = "psVCTableViewCellID"
}

struct PSViewControllerModel {
    let name: String
    let aboutText: String
}

struct PSModel {
    let image: String
    let menuText: String
}

final class ProfileSettingViewController: UIViewController {
    
    //MARK: - Private Properties UI
    
    private let models = [PSModel(image: "profile", menuText: "Account Setting"),
                          PSModel(image: "done", menuText: "Change Password"),
                          PSModel(image: "shape", menuText: "Forget Password")]
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [avatarImageView, labelsStackView])
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.crop.circle"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, aboutMySelfLabel])
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel(
            text: "Danila Bolshakov",
            font: .regular14(),
            textColor: .black,
            textAlignment: .left,
            numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aboutMySelfLabel: UILabel = {
        let label = UILabel(
            text: "Love,life and chill",
            font: .regular14(),
            textColor: .boldGrayTextColor,
            textAlignment: .left,
            numberOfLines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(ProfileSettingViewControllerTableViewCell.self, forCellReuseIdentifier: Theme.psVCTableViewCellID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let logOutButton = UIButton(
        title: "Log Out",
        backgroundColor: .clear,
        titleColor: .activeBlueColor,
        font: .jakarta16(),
        hasBorder: false,
        cornerRadius: 32
    )

    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setupConstraints()
    }
    
    func configure(model: PSViewControllerModel) {
        avatarImageView.image = UIImage(named: model.name)
    }
    
    //MARK: - Setup Views
    
    private func setViews() {
        view.addSubviews(headerStackView, settingsTableView, logOutButton)
        view.backgroundColor = .white
    }
}

//MARK: - Setup Constraints

extension ProfileSettingViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            avatarImageView.heightAnchor.constraint(equalToConstant: 52),
            avatarImageView.widthAnchor.constraint(equalToConstant: 48),
            
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 56),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            settingsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            settingsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            settingsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -250),
            
            logOutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 650),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -140),
        ])
    }
}

//MARK: - UITableViewDataSource

extension ProfileSettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Theme.psVCTableViewCellID, for: indexPath) as? ProfileSettingViewControllerTableViewCell  else { return UITableViewCell() }
        let item = models[indexPath.row]
        cell.selectionStyle = .none
        cell.configure(model: item)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ProfileSettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            navigationController?.pushViewController(AccountSettingViewController(), animated: false)
        case 1:
            navigationController?.pushViewController(AccountSettingViewController(), animated: false)
        case 2:
            navigationController?.pushViewController(AccountSettingViewController(), animated: false)
        default:
            break
        }
    }
}

