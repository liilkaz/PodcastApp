//
//  CreatePlaylistCell.swift
//  PodcastApp
//
//  Created by sidzhe on 27.09.2023.
//

import UIKit
import SnapKit

final class CreatePlaylistCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    weak var viewModel: CreatePlaylistCellProtocol? {
        willSet {
        
            activityIndicator.startAnimating()
            songName.text = newValue?.songName
            contentLabel.text = newValue?.contentName
            newValue?.icon.bind { [weak self] icon in
                guard let self else { return }
                self.activityIndicator.stopAnimating()
                self.iconImage.image = icon
            }
        }
    }
    
    //MARK: - UI Elements
    
    lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .systemGray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var songName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 4
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark"), for: .selected)
        button.tintColor = .black
        button.backgroundColor = .clear
        button.clipsToBounds = true
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.layer.cornerRadius = 8
        return button
    }()
    
    //MARK: - Inits
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImage.image = nil
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func setupViews() {
        
        stackView.addArrangedSubview(songName)
        stackView.addArrangedSubview(contentLabel)
        
        iconImage.addSubviews(activityIndicator)
        
        contentView.addSubview(iconImage)
        contentView.addSubview(stackView)
        contentView.addSubview(addButton)
        
        iconImage.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(8)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(iconImage.snp.right).inset(-18)
            make.right.equalTo(addButton.snp.left).inset(-8)
            make.top.equalTo(iconImage.snp.top)
        }
        
        addButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.right.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func tapAddButton(_ sender: UIButton) {
        sender.isSelected.toggle()
        sender.backgroundColor = sender.backgroundColor == .clear ? .systemGreen : .clear
        sender.tintColor = sender.tintColor == .black ? .white : .black
        sender.layer.borderWidth = sender.layer.borderWidth == 1.5 ? 0.0 : 1.5
        print("add")
    }
}

