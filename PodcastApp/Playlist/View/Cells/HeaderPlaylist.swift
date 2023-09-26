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
        label.text = "Playlist"
        label.textAlignment = .center
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
        
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(32)
        }
    }
}
