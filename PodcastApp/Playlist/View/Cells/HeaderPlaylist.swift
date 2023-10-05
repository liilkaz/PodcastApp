//
//  HeaderPlaylist.swift
//  PodcastApp
//
//  Created by sidzhe on 05.10.2023.
//

import UIKit
import SnapKit

final class HeaderPlaylist: UICollectionReusableView {
    
    //MARK: - Properties
    
    var completionHandler: (() -> Void)?
    
    //MARK: - UI Elements
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Playlist"
        label.textAlignment = .center
        label.font = UIFont.semiBold()
        return label
    }()
    
    private lazy var backgrView: UIView = {
        let view = UIView()
        view.tintColor = .black
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = .lightGray
        return view
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
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(tapCreateButton), for: .touchUpInside)
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
        
        backgrView.addSubview(backgrImage)
        
        addSubview(headerLabel)
        addSubview(backgrView)
        addSubview(createLabel)
        addSubview(createButton)
        
        backgrImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(20)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(32)
        }
        
        backgrView.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.left.equalTo(headerLabel.snp.left)
            make.top.equalTo(headerLabel.snp.bottom).inset(-16)
        }
        
        createLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backgrView.snp.centerY)
            make.left.equalTo(backgrView.snp.right).inset(-16)
        }
        
        createButton.snp.makeConstraints { make in
            make.top.equalTo(backgrView.snp.top)
            make.bottom.equalTo(backgrView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    @objc private func tapCreateButton() {
        completionHandler?()
    }
}
