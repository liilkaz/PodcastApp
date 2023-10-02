import UIKit

class ChannelHeaderView: UITableViewHeaderFooterView {
    static let identifier = "ChannelHeaderView"
    private lazy var allEpisodeLabel = UILabel(text: "All Episode", font: .boldSystemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(allEpisodeLabel)
        NSLayoutConstraint.activate([
            allEpisodeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            allEpisodeLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
