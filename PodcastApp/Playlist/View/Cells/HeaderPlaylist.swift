//
//  HeaderPlaylist.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import UIKit
import SnapKit

final class HeaderPlaylist: UICollectionReusableView {
    
    //MARK: - UI Elements
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Playlist"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var backgrImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
        image.tintColor = .black
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.backgroundColor = .lightGray
        return image
    }()
    
    private lazy var createLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Playlist"
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
        
        addSubview(headerLabel)
        addSubview(backgrImage)
        addSubview(createLabel)
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview()
        }
        
        backgrImage.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.left.equalTo(headerLabel.snp.left)
            make.top.equalTo(headerLabel.snp.bottom).inset(-16)
        }
        
        createLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backgrImage.snp.centerY)
            make.left.equalTo(backgrImage.snp.right).inset(-12)
        }
    }
}
