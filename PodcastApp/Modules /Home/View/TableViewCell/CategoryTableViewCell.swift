import UIKit


protocol CategoryPressedDelegate: AnyObject {
    func categoryPressed(with model: ChannelModel)
}

protocol CategoryTagPressedDelegate: AnyObject {
    func categoryTagPressed(with model: [Item])
}

class CategoryTableViewCell: UITableViewCell {
    weak var categoryDelegate: CategoryPressedDelegate?
    weak var tagDelegate: CategoryTagPressedDelegate?
    
    static let identifier = "CategoryTableViewCell"
    private var lastSelectedIndexPath: IndexPath? = nil
    
    private let homeViewModel = HomeViewModel()
    private lazy var personFullnameLabel = UILabel(text: "Abigael Amaniah", font: .boldSystemFont(ofSize: 16), textColor: .black, textAlignment: .center)
    private lazy var loveLifeAndChillLabel = UILabel(text: "Love, Life, and chill", font: .systemFont(ofSize: 14), textColor: .darkGray, textAlignment: .center)
    private lazy var profileImage: UIImageView = {
        let image = UIImageView(cornerRadius: 12)
        image.backgroundColor = .systemBlue
        return image
    }()
    private lazy var categoryLabel = UILabel(text: "Category", font: .systemFont(ofSize: 20), textColor: .black, textAlignment: .center)
    
    private lazy var categoryCollectionView: UICollectionView = {
        let collection = UICollectionView(dataSource: self, delegate: self, width: 150, height: 200)
        collection.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        return collection
    }()
    
    private lazy var categoryTagCollectionView: UICollectionView = {
        let collection = UICollectionView(dataSource: self, delegate: self, width: 120, height: 50)
        collection.register(CategoryTagCollectionViewCell.self, forCellWithReuseIdentifier: CategoryTagCollectionViewCell.identifier)
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        categoryTagCollectionView.allowsMultipleSelection = false
        lastSelectedIndexPath = IndexPath(row: 0, section: 0)
        setupUI()
        callNetworkingForFirstCell()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func callNetworkingForFirstCell() {
        homeViewModel.fetchPodcast(creator: "Emma") { [weak self] result in
            switch result {
            case .success(let success):
                self?.tagDelegate?.categoryTagPressed(with: success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func setupUI() {
        personFullnameLabel.text = UserDefaults.standard.value(forKey: "name") as? String
        contentView.addSubviews(personFullnameLabel, loveLifeAndChillLabel, profileImage, categoryLabel, categoryCollectionView, categoryTagCollectionView)
        
        
        NSLayoutConstraint.activate([
            personFullnameLabel.heightAnchor.constraint(equalToConstant: 25),
            personFullnameLabel.topAnchor.constraint(equalTo: topAnchor),
            personFullnameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            loveLifeAndChillLabel.heightAnchor.constraint(equalToConstant: 25),
            loveLifeAndChillLabel.topAnchor.constraint(equalTo: personFullnameLabel.bottomAnchor, constant: 5),
            loveLifeAndChillLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
        ])
        
        
        NSLayoutConstraint.activate([
            profileImage.heightAnchor.constraint(equalToConstant: 45),
            profileImage.widthAnchor.constraint(equalToConstant: 45),
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            profileImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
        
        NSLayoutConstraint.activate([
            categoryLabel.heightAnchor.constraint(equalToConstant: 25),
            categoryLabel.topAnchor.constraint(equalTo: loveLifeAndChillLabel.bottomAnchor, constant: 30),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            categoryCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 210)
        ])
        
        NSLayoutConstraint.activate([
            categoryTagCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 30),
            categoryTagCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            categoryTagCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            categoryTagCollectionView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension CategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categoryCollectionView: return homeViewModel.categoryArray.count
        case categoryTagCollectionView: return 10
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categoryCollectionView:
            let title = homeViewModel.categoryArray[indexPath.row]
            let image = homeViewModel.categoryImageArray[indexPath.row]
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
            cell.configureCell(image: image, title: title, tracks: 100)
            return cell
        case categoryTagCollectionView:
            let creatorName = homeViewModel.categoryTagArray[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryTagCollectionViewCell.identifier, for: indexPath) as! CategoryTagCollectionViewCell
            if indexPath == lastSelectedIndexPath {
                cell.backgroundColor = .collectionSelectedColor
                cell.categoryLabel.textColor = .black
            }
            cell.configureCell(text: creatorName)
            return cell
        default: return UICollectionViewCell()
        }
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case categoryCollectionView:
            let model = ChannelModel(image: homeViewModel.categoryImageArray[indexPath.row], title: homeViewModel.categoryArray[indexPath.row].rawValue)
            categoryDelegate?.categoryPressed(with: model)
        case categoryTagCollectionView:
            let creator = homeViewModel.categoryTagArray[indexPath.row]
            homeViewModel.fetchPodcast(creator: creator) { [weak self] result in
                switch result {
                case .success(let success):
                    self?.tagDelegate?.categoryTagPressed(with: success)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        default: break
        }
        
        
        if categoryTagCollectionView == collectionView {
            if let lastIndexPath = lastSelectedIndexPath,
                let lastCell = collectionView.cellForItem(at: lastIndexPath) as? CategoryTagCollectionViewCell {
                lastCell.isSelected = false
            }
            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryTagCollectionViewCell {
                cell.isSelected = true
                lastSelectedIndexPath = indexPath
            }
        }
    }
}
