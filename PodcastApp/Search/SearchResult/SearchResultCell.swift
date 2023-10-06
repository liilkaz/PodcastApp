//
//  SearchAllCell.swift
//  PodcastApp
//
//  Created by Anna Zaitsava on 2.10.23.
//

import UIKit

class SearchResultCell: UITableViewCell {
    static let identifier = "SearchResultCell"
    
    
    private lazy var podcastImage: UIImageView = {
        let image = UIImageView(cornerRadius: 14)
        image.image = UIImage(named: "beauty")
        //        image.backgroundColor = .tableViewColor
        return image
    }()
    
    private lazy var podcastLabel = UILabel(text: "Baby Pesut Podcast", font: .manrope16bold(), textColor: .black, textAlignment: .left, numberOfLines: 0)
    private lazy var episodeLabel = UILabel(text: "56:38", font: .manrope14(), textColor: .darkGray, textAlignment: .left)
    private lazy var chanelLabel = UILabel(text: "Dr. Oi om jean", font: .manrope14(), textColor: .darkGray, textAlignment: .left)
    
    
    private func setupUI() {
        
        
        contentView.addSubviews(podcastImage, podcastLabel, episodeLabel, chanelLabel)
        NSLayoutConstraint.activate([
            
            podcastImage.widthAnchor.constraint(equalToConstant: 56),
            podcastImage.heightAnchor.constraint(equalToConstant: 56),
            podcastImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            podcastImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 14),
            
            podcastLabel.topAnchor.constraint(equalTo: podcastImage.topAnchor),
            podcastLabel.leadingAnchor.constraint(equalTo: podcastImage.trailingAnchor, constant: 12),
            podcastLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            episodeLabel.topAnchor.constraint(equalTo: podcastLabel.bottomAnchor, constant: 5),
            episodeLabel.leadingAnchor.constraint(equalTo: podcastLabel.leadingAnchor),
            
            chanelLabel.topAnchor.constraint(equalTo: podcastLabel.bottomAnchor, constant: 5),
            chanelLabel.leadingAnchor.constraint(equalTo: episodeLabel.trailingAnchor, constant: 10)
        ])
        
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

