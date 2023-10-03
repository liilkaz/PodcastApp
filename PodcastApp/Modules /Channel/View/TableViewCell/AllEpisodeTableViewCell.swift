import UIKit

class AllEpisodeTableViewCell: UITableViewCell {
    static let identifier = "AllEpisodeTableViewCell"
    private lazy var episodeView = CornerRadiusUIView(background: .tableViewColor, rounding: 12)
    private lazy var episodeImage: UIImageView = {
        let image = UIImageView(cornerRadius: 12)
        image.backgroundColor = .systemGreen
        return image
    }()
    
    private lazy var episodeNameLabel = UILabel(text: "Between love and career", font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .center)
    private lazy var episodeTimeLabel = UILabel(text: "56:38", font: .systemFont(ofSize: 12), textColor: .systemGray, textAlignment: .center)
    private lazy var episodeLabel = UILabel(text: "56 Eps", font: .systemFont(ofSize: 12), textColor: .systemGray, textAlignment: .center)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        contentView.addSubviews(episodeView)
        episodeView.addSubviews(episodeImage, episodeNameLabel, episodeTimeLabel, episodeLabel)
        
        NSLayoutConstraint.activate([
            episodeView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            episodeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            episodeView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            episodeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            episodeImage.widthAnchor.constraint(equalToConstant: 56),
            episodeImage.topAnchor.constraint(equalTo: episodeView.topAnchor, constant: 8),
            episodeImage.leadingAnchor.constraint(equalTo: episodeView.leadingAnchor, constant: 8),
            episodeImage.bottomAnchor.constraint(equalTo: episodeView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            episodeNameLabel.topAnchor.constraint(equalTo: episodeView.topAnchor, constant: 15),
            episodeNameLabel.leadingAnchor.constraint(equalTo: episodeImage.trailingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            episodeTimeLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 5),
            episodeTimeLabel.leadingAnchor.constraint(equalTo: episodeImage.trailingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            episodeLabel.topAnchor.constraint(equalTo: episodeNameLabel.bottomAnchor, constant: 5),
            episodeLabel.leadingAnchor.constraint(equalTo: episodeTimeLabel.trailingAnchor, constant: 20)
        ])
    }
    
}
