//
//  TopGenreCell.swift
//  PodcastApp
//
//  Created by Anna Zaitsava on 2.10.23.
//

import UIKit

class TopGenreCell: UITableViewCell {
    var genresarr = GenresHardData()
    static let identifier = "TopGenreCell"
    private var lastSelectedIndexPath: IndexPath? = nil

    
    private lazy var sectionOneLabel = UILabel(text: "Top Genres", font: .manrope16bold(), textColor: .black)
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton(title: "See All", backgroundColor: .clear, titleColor: .gray, font: .manrope16() , hasBorder: false)
        button.addTarget(self, action: #selector(seeAllButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var topCategoryCollectionView: UICollectionView = {
        let collection = UICollectionView(dataSource: self, delegate: self, width: 147, height: 84)
        collection.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        return collection
    }()
    

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        lastSelectedIndexPath = IndexPath(row: 0, section: 0)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews(sectionOneLabel,seeAllButton,topCategoryCollectionView )
        
        
        NSLayoutConstraint.activate([
            sectionOneLabel.heightAnchor.constraint(equalToConstant: 22),
            sectionOneLabel.topAnchor.constraint(equalTo: topAnchor),
            sectionOneLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
      
            seeAllButton.heightAnchor.constraint(equalToConstant: 25),
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            seeAllButton.topAnchor.constraint(equalTo: topAnchor),
    
            topCategoryCollectionView.topAnchor.constraint(equalTo: sectionOneLabel.bottomAnchor, constant: 13),
            topCategoryCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            topCategoryCollectionView.heightAnchor.constraint(equalToConstant: 84),
            

        ])
    }
    
    @objc func seeAllButtonPressed(_ sender: UIButton) {
        print("See all button pressed")
    }
}

extension TopGenreCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return genresarr.topGenres.count
        }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let title = genresarr.topGenres[indexPath.row]
            let image = UIImage(systemName: "")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
            cell.configureCell(image: image, title: title)
            return cell

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return genresarr.allGenres.count
    }
}


    
    extension TopGenreCell: UICollectionViewDelegate {
        
    }
    

