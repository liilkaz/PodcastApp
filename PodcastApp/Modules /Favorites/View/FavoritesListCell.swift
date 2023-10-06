import UIKit
import SnapKit

final class FavoritesListCell: UICollectionViewCell {

    //MARK: - Properties
    
    weak var viewModel: FavoritsCellViewModelProtocol? {
        willSet {

            activityIndicator.startAnimating()
            songName.text = newValue?.songName
            contentLabel.text = newValue?.contentName
            newValue?.icon.bind { [weak self] icon in
                guard let self else { return }
                Task { self.activityIndicator.stopAnimating() }
                self.iconImage.image = icon
            }
        }
    }
    //MARK: - UI Elements
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private lazy var iconImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.backgroundColor = .lightGray
        return image
    }()

    private lazy var songName = UILabel(font: .regular14(),
                                        textColor: .blackTextColor, numberOfLines: 1)

    private lazy var contentLabel = UILabel (font: .regular10(),
                                             textColor: .customGray2, numberOfLines: 1)

    //MARK: - Inits
    
    override func prepareForReuse() {
        super.prepareForReuse()

        iconImage.image = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    
    private func setupViews() {

        iconImage.addSubviews(activityIndicator)

        contentView.addSubview(iconImage)
        contentView.addSubview(songName)
        contentView.addSubview(contentLabel)

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        iconImage.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.top.equalToSuperview().inset(26)
            make.horizontalEdges.equalToSuperview().inset(30)
        }

        songName.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(iconImage.snp.bottom).inset(-12)
        }

        contentLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(10)
            make.top.equalTo(songName.snp.bottom).inset(-4)
        }
    }
}
