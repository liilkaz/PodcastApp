//
//  FavoritesListCell.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import UIKit
import SnapKit

final class FavoritesListCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    weak var viewModel: FavoritsCellViewModelProtocol? {
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
        
        contentView.addSubview(iconImage)
        contentView.addSubview(songName)
        contentView.addSubview(contentLabel)
        
        iconImage.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.top.equalToSuperview().inset(26)
            make.horizontalEdges.equalToSuperview().inset(30)
        }
        
        songName.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(iconImage.snp.bottom).inset(-10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(songName.snp.bottom).inset(-4)
        }
    }
}
