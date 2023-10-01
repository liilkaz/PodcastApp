import UIKit

class CategoryTagCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryTagCollectionViewCell"
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
                categoryLabel.textColor = .black
            } else {
                backgroundColor = .clear
                categoryLabel.textColor = .gray
            }
        }
    }
    
     lazy var categoryLabel = UILabel(text: "🔥 Popular", font: .systemFont(ofSize: 15), textColor: .gray, textAlignment: .center)
    
    private func setupUI() {
        contentView.addSubview(categoryLabel)
        NSLayoutConstraint.activate([
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 12
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
