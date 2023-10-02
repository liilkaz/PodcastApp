import UIKit

class ChannelMusicInfoTableViewCell: UITableViewCell {
    static let identifier = "ChannelMusicInfoTableViewCell"
    private lazy var trackImage: UIImageView = {
        let image = UIImageView(cornerRadius: 12)
        image.backgroundColor = .systemBlue
        return image
    }()
    private lazy var musicLabel = UILabel(text: "Baby Pesut Podcast", font: .boldSystemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    private lazy var episodeCountLabel = UILabel(text: "56 Eps", font: .systemFont(ofSize: 14), textColor: .systemGray, textAlignment: .center)
    private lazy var creatorLabel = UILabel(text: "Dr. Oi om jean", font: .systemFont(ofSize: 14), textColor: .systemGray, textAlignment: .center)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        contentView.addSubviews(trackImage, musicLabel, episodeCountLabel, creatorLabel)
        
        NSLayoutConstraint.activate([
            trackImage.heightAnchor.constraint(equalToConstant: 84),
            trackImage.widthAnchor.constraint(equalToConstant: 84),
            trackImage.topAnchor.constraint(equalTo: topAnchor),
            trackImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            musicLabel.topAnchor.constraint(equalTo: trackImage.bottomAnchor, constant: 24),
            musicLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 110),
            musicLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -110)
        ])
        
        NSLayoutConstraint.activate([
            episodeCountLabel.topAnchor.constraint(equalTo: musicLabel.bottomAnchor, constant: 5),
            episodeCountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 110)
        ])
        
        NSLayoutConstraint.activate([
            creatorLabel.topAnchor.constraint(equalTo: musicLabel.bottomAnchor, constant: 5),
            creatorLabel.leadingAnchor.constraint(equalTo: episodeCountLabel.trailingAnchor, constant: 15)
        ])
        
    }
    
}
