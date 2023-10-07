import UIKit

protocol TapGenresCollectionPressed: AnyObject {
    func tapGenreCollection(with title: String)
}

class TopGenreCollection: UITableViewCell {
    static let identifier = "TopGenreCollection"
    weak var delegate: TapGenresCollectionPressed?
    var genresarr = TopGenres.allCases.map { $0.rawValue }
    
    private lazy var sectionOneLabel = UILabel(text: "Top Genres", font: .manrope16bold(), textColor: .black)
    
    private lazy var topCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 17
        layout.minimumLineSpacing = 17
        layout.itemSize = CGSize(width: 150, height: 85)

        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(GenreCell.self, forCellWithReuseIdentifier: GenreCell.identifier)
        collectionview.backgroundColor = .clear
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.showsHorizontalScrollIndicator = false
        return collectionview
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews(sectionOneLabel,topCategoryCollectionView )
        
        NSLayoutConstraint.activate([
            sectionOneLabel.heightAnchor.constraint(equalToConstant: 22),
            sectionOneLabel.topAnchor.constraint(equalTo: topAnchor),
            sectionOneLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            topCategoryCollectionView.topAnchor.constraint(equalTo: sectionOneLabel.bottomAnchor, constant: 13),
            topCategoryCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            topCategoryCollectionView.heightAnchor.constraint(equalToConstant: 84),
        ])
    }
}

extension TopGenreCollection: UICollectionViewDataSource {
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

extension TopGenreCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tapGenreCollection(with: genresarr[indexPath.row])
    }
}
