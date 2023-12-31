import UIKit

class HomeTableViewCell: UITableViewCell {
    var savePodcastViewModel = SavePodcastViewModel()
    static let identifier = "HomeTableViewCell"
    private var isIconChanged = false
    private lazy var homeCellView = CornerRadiusUIView(background: .tableViewColor, rounding: 12)
    
    private lazy var musicImage: UIImageView = {
        let image = UIImageView(cornerRadius: 12)
        image.backgroundColor = .systemBlue
        return image
    }()
    
    private lazy var musicLabel = UILabel(text: "Моя тень и я", font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .left)
    private lazy var performerLabel = UILabel(text: "Kizaru", font: .systemFont(ofSize: 12), textColor: .darkGray, textAlignment: .left)
    private lazy var categoryMusicLabel = UILabel(text: "Hip-Hop", font: .systemFont(ofSize: 12), textColor: .darkGray, textAlignment: .left)
    private lazy var episodeLabel = UILabel(text: "41 Eps", font: .systemFont(ofSize: 12), textColor: .darkGray, textAlignment: .left)
    lazy var likeButton: UIButton = {
        let button = UIButton(text: "", textColor: .clear, backgroundColor: .clear)
        button.setImage(UIImage(systemName: "heart")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(likeButtonPressed(_:)), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    @IBAction func likeButtonPressed(_ sender: UIButton) {
        guard let model = savePodcastViewModel.podcastItem,
            let id = model.feedID,
            let podcastURL = model.enclosureURL,
            let imageURL = model.feedImage,
            let title = model.title,
            let creator = model.feedAuthor
        else {
            return
        }
        
        isIconChanged.toggle()
        if isIconChanged {
            sender.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
            savePodcastViewModel.realmDatabase.savePodcastToRealm(id: id, podcastURL: podcastURL, imageURL: imageURL, title: title, creator: creator)
        } else {
            sender.setImage(UIImage(systemName: "heart")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
            savePodcastViewModel.realmDatabase.deletePodcastFromRealm(id: id)
            print(savePodcastViewModel.realmDatabase.loadFavoritesPodcastFromRealm())
        }
    }
    public func configureCell(with model: Item) {
        musicLabel.text = model.title
        performerLabel.text = model.feedAuthor
        savePodcastViewModel.podcastItem = model
        
        Task{
            let image = try await savePodcastViewModel.networkService.loadImageTask(from: model.feedImage!)
            musicImage.image = image
        }
        
        savePodcastViewModel.realmDatabase.checkPodcastInRealm(id: model.feedID!) {
            self.likeButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        } failureCompletion: {
            self.likeButton.setImage(UIImage(systemName: "heart")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
            
        }

    }
    
    private func setupUI() {
        contentView.addSubviews(homeCellView)
        homeCellView.addSubviews(musicImage, musicLabel, performerLabel, categoryMusicLabel, episodeLabel, likeButton)
        NSLayoutConstraint.activate([
            homeCellView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            homeCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            homeCellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            homeCellView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            musicImage.widthAnchor.constraint(equalToConstant: 56),
            musicImage.topAnchor.constraint(equalTo: homeCellView.topAnchor, constant: 8),
            musicImage.leadingAnchor.constraint(equalTo: homeCellView.leadingAnchor, constant: 8),
            musicImage.bottomAnchor.constraint(equalTo: homeCellView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            musicLabel.topAnchor.constraint(equalTo: homeCellView.topAnchor, constant: 15),
            musicLabel.leadingAnchor.constraint(equalTo: musicImage.trailingAnchor, constant: 10),
            musicLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            performerLabel.topAnchor.constraint(equalTo: homeCellView.topAnchor, constant: 15),
            performerLabel.leadingAnchor.constraint(equalTo: musicLabel.trailingAnchor, constant: 10),

            performerLabel.trailingAnchor.constraint(equalTo: homeCellView.trailingAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            categoryMusicLabel.bottomAnchor.constraint(equalTo: homeCellView.bottomAnchor, constant: -15),
            categoryMusicLabel.leadingAnchor.constraint(equalTo: musicImage.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            episodeLabel.bottomAnchor.constraint(equalTo: homeCellView.bottomAnchor, constant: -15),
            episodeLabel.leadingAnchor.constraint(equalTo: categoryMusicLabel.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: homeCellView.topAnchor, constant: 5),
            likeButton.bottomAnchor.constraint(equalTo: homeCellView.bottomAnchor, constant: -5),
            likeButton.trailingAnchor.constraint(equalTo: homeCellView.trailingAnchor, constant: -10)
        ])
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        musicImage.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
