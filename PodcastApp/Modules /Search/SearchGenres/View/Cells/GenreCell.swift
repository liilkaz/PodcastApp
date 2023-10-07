import UIKit

class GenreCell: UICollectionViewCell {
    static let identifier = "GenreCell"
    
    private lazy var genreLabel = UILabel(text: "Music and chill", font: .manrope14regular(), textColor: .white, textAlignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews(genreLabel)
        setupUI()
    }
    
    public func configureCell(title: String) {
        self.genreLabel.text = title
    }
        
    private func setupUI() {
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 12
        NSLayoutConstraint.activate([
            genreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            genreLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
