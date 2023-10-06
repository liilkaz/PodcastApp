//
//  SearchAllCell.swift
//  PodcastApp
//
//  Created by Anna Zaitsava on 2.10.23.
//

import UIKit

class AllPodcastsCell: UITableViewCell {
    static let identifier = "AllPodcastsCell"
    
    private lazy var searchCellView = CornerRadiusUIView(background: .tableViewColor, rounding: 16)
    
    private lazy var podcastImage: UIImageView = {
        let image = UIImageView(cornerRadius: 16)
        image.backgroundColor = .blue
        return image
    }()
    
    private lazy var podcastLabel = UILabel(text: "Between love and career", font: .manrope14bold(), textColor: .black, textAlignment: .left, numberOfLines: 0)

    private lazy var durationLabel = UILabel(text: "56:38", font: .manrope12(), textColor: .darkGray, textAlignment: .left)
    private lazy var episodeLabel = UILabel(text: "56 Eps", font: .manrope12(), textColor: .darkGray, textAlignment: .left)
    
    
    private func setupUI() {
        contentView.addSubviews(searchCellView)
        searchCellView.addSubviews(podcastImage, podcastLabel, durationLabel, episodeLabel)
        NSLayoutConstraint.activate([
            searchCellView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            searchCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            searchCellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchCellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            podcastImage.widthAnchor.constraint(equalToConstant: 56),
            podcastImage.heightAnchor.constraint(equalToConstant: 56),
            podcastImage.topAnchor.constraint(equalTo: searchCellView.topAnchor, constant: 8),
            podcastImage.leadingAnchor.constraint(equalTo: searchCellView.leadingAnchor, constant: 8),

            podcastLabel.topAnchor.constraint(equalTo: searchCellView.topAnchor, constant: 15),
            podcastLabel.leadingAnchor.constraint(equalTo: podcastImage.trailingAnchor, constant: 20),
            podcastLabel.trailingAnchor.constraint(equalTo: searchCellView.trailingAnchor, constant: -20),

            durationLabel.bottomAnchor.constraint(equalTo:  podcastLabel.bottomAnchor, constant: 20),
            durationLabel.leadingAnchor.constraint(equalTo: podcastImage.trailingAnchor, constant: 20),

            episodeLabel.bottomAnchor.constraint(equalTo:  podcastLabel.bottomAnchor, constant: 20),
            episodeLabel.leadingAnchor.constraint(equalTo: durationLabel.trailingAnchor, constant: 10)
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

