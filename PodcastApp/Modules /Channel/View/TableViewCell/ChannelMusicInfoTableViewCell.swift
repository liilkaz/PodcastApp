import UIKit

class ChannelMusicInfoTableViewCell: UITableViewCell {
    static let identifier = "ChannelMusicInfoTableViewCell"
    private lazy var trackImage: UIImageView = {
        let image = UIImageView(cornerRadius: 12)
        image.backgroundColor = .systemBlue
        return image
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(with model: ChannelModel) {
        trackImage.image = model.image
    }
    
    
    private func setupUI() {
        contentView.addSubviews(trackImage)
        NSLayoutConstraint.activate([
            trackImage.topAnchor.constraint(equalTo: topAnchor),
            trackImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            trackImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            trackImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
