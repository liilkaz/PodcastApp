import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    private lazy var categoryImage: UIImageView = {
        let image = UIImageView(cornerRadius: 12)
        image.backgroundColor = .systemPink
        return image
    }()
    
    private lazy var musicView = UIView(background: .lightPinkColor, cornerRadius: 12)
    private lazy var categoryMusic = UILabel(text: "Music & Fun", font: .boldSystemFont(ofSize: 15), textColor: .black, textAlignment: .left)
    private lazy var countMusic = UILabel(text: "100 tracks", font: .systemFont(ofSize: 10), textColor: .black, textAlignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(categoryImage)
        categoryImage.addSubviews(musicView, categoryMusic, countMusic)
        setupUI()
    }
    
    public func configureCell(image: UIImage?, title: CategoryMusic, tracks: Int) {
        self.categoryImage.image = image
        self.categoryMusic.text = title.rawValue
        self.countMusic.text = "\(tracks) tracks"
    }
    
    private func setupUI() {
        self.layer.cornerRadius = 12
        NSLayoutConstraint.activate([
            categoryImage.topAnchor.constraint(equalTo: topAnchor),
            categoryImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            categoryImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            musicView.heightAnchor.constraint(equalToConstant: 65),
            musicView.bottomAnchor.constraint(equalTo: categoryImage.bottomAnchor),
            musicView.leadingAnchor.constraint(equalTo: categoryImage.leadingAnchor),
            musicView.trailingAnchor.constraint(equalTo: categoryImage.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            categoryMusic.topAnchor.constraint(equalTo: musicView.topAnchor, constant: 14),
            categoryMusic.leadingAnchor.constraint(equalTo: musicView.leadingAnchor, constant: 14)
        ])
        
        NSLayoutConstraint.activate([
            countMusic.bottomAnchor.constraint(equalTo: musicView.bottomAnchor, constant: -14),
            countMusic.leadingAnchor.constraint(equalTo: musicView.leadingAnchor, constant: 14)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
