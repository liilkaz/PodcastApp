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
            iconImage.image = UIImage(systemName: newValue!.icon) ?? UIImage()
            songName.text = newValue?.songName
            contentLabel.text = newValue?.contentName
        }
    }
    
    //MARK: - UI Elements
    
    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "swift")
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private lazy var songName: UILabel = {
        let label = UILabel()
        label.text = "Tuhan mengapa dia berbeda"
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "30 Eps"
        label.textColor = .lightGray
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fill
        view.axis = .vertical
        view.spacing = 10
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        button.tintColor = .black
        return button
    }()
    
    //MARK: - Inits
    
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
        
        contentView.addSubview(iconImage)
        contentView.addSubview(stackView)
        contentView.addSubview(addButton)
        
        iconImage.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.left.equalTo(iconImage.snp.right).inset(-18)
            make.right.equalTo(addButton.snp.left)
            make.top.equalTo(iconImage.snp.top)
        }
        
        addButton.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.right.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func tapAddButton() {
        print("add")
    }
}

