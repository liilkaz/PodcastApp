import UIKit

protocol BrowseAllButtonPressed: AnyObject {
    func browseAllCollection(with title: String)
}

class BrowseAllCollection: UITableViewCell {
    weak var delegate: BrowseAllButtonPressed?
    var genresarr = AllGenres.allCases.map { $0.rawValue }
    static let identifier = "BrowseAllCollection"
    
    private lazy var sectionLabel = UILabel(text: "Browse All", font: .manrope16bold(), textColor: .black)
    
    private lazy var browseAllCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 17
        layout.minimumLineSpacing = 17
        layout.itemSize = CGSize(width: 147, height: 84)
        
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = .clear
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.isScrollEnabled = false
        return collectionview
    }()
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 85)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    }
    
    @objc func seeAllButtonPressed(_ sender: UIButton) {
        print("See all button pressed")
    }
}

extension BrowseAllCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genresarr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let title = genresarr[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCell.identifier, for: indexPath) as! GenreCell
        cell.configureCell(title: title)
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}


extension BrowseAllCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.browseAllCollection(with: genresarr[indexPath.row])
    }
}
