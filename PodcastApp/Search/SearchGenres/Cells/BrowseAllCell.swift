//
//  BrowseAllCell.swift
//  PodcastApp
//
//  Created by Anna Zaitsava on 2.10.23.
//

import UIKit

class BrowseAllCell: UITableViewCell {
    var genresarr = GenresHardData()
    static let identifier = "BrowseAllCell"
    private var lastSelectedIndexPath: IndexPath? = nil

    
    
    private lazy var sectionLabel = UILabel(text: "Browse All", font: .manrope16bold(), textColor: .black)

    
    private lazy var browseAllCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 17
        layout.minimumLineSpacing = 17
        layout.itemSize = CGSize(width: 147, height: 84)
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.isScrollEnabled = false 
        return collectionview
    }()
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 147, height: 84)
    }
    
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
            contentView.addSubviews(sectionLabel, browseAllCollectionView)
            
            NSLayoutConstraint.activate([
                sectionLabel.heightAnchor.constraint(equalToConstant: 22),
                sectionLabel.topAnchor.constraint(equalTo: topAnchor),
                sectionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                
                browseAllCollectionView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 21),
                browseAllCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
                browseAllCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
                browseAllCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            

            browseAllCollectionView.register(BrowseCell.self, forCellWithReuseIdentifier: BrowseCell.identifier)
        

    }
    
    @objc func seeAllButtonPressed(_ sender: UIButton) {
        print("See all button pressed")
    }
    
    
}

extension BrowseAllCell: UICollectionViewDataSource, UICollectionViewDelegate {

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genresarr.allGenres.count
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let title = genresarr.allGenres[indexPath.row]
        let image = UIImage(systemName: "")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowseCell.identifier, for: indexPath) as! BrowseCell
        cell.configureCell(image: image, title: title)
        return cell
    }

    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}





    
    
    



