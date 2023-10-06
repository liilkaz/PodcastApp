//
//  TopGenreCell.swift
//  PodcastApp
//
//  Created by Anna Zaitsava on 2.10.23.
//

import UIKit

class GenreCell: UICollectionViewCell {
    static let identifier = "GenreCell"
    
    private lazy var categoryImage: UIImageView = {
        let image = UIImageView(cornerRadius: 12)
        image.backgroundColor = .blue
        return image
    }()
    
    private lazy var genreLabel = UILabel(text: "Music and chill", font: .manrope14(), textColor: .white, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(categoryImage)
        categoryImage.addSubviews(genreLabel)
        setupUI()
    }
    
    public func configureCell(image: UIImage?, title: String) {
        self.categoryImage.image = image
        self.genreLabel.text = title
    }
        
    private func setupUI() {
        self.layer.cornerRadius = 12
        NSLayoutConstraint.activate([
            categoryImage.topAnchor.constraint(equalTo: topAnchor),
            categoryImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            genreLabel.centerXAnchor.constraint(equalTo: categoryImage.centerXAnchor),
            genreLabel.centerYAnchor.constraint(equalTo: categoryImage.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

