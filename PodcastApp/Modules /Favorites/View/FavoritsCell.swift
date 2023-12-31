import UIKit
import SnapKit

final class FavoritsCell: UICollectionViewCell {

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
        return image
    }()

    private lazy var songName = UILabel(font: .regular14(), textColor: .blackTextColor)


    private lazy var contentLabel = UILabel(font: .regular10(), textColor: .customGray2)

    private lazy var stackView = UIStackView(axis: .vertical, spacing: 10)

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
        stackView.distribution = .fill

        iconImage.addSubviews(activityIndicator)

        stackView.addArrangedSubview(songName)
        stackView.addArrangedSubview(contentLabel)

        contentView.addSubview(iconImage)
        contentView.addSubview(stackView)

        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        iconImage.snp.makeConstraints { make in
            make.size.equalTo(48)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.left.equalTo(iconImage.snp.right).inset(-12)
            make.right.equalToSuperview()
            make.top.equalTo(iconImage.snp.top)
        }
    }
}
