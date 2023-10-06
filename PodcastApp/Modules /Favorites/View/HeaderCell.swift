import UIKit
import SnapKit

final class HeaderCell: UICollectionReusableView {

    //MARK: - UI Elements
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Favorites"
        label.textAlignment = .center
        label.font = UIFont.jakartaBold(size: 16)
        return label
    }()

    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all", for: .normal)
        button.addTarget(self, action: #selector(tapSellAllButton), for: .touchUpInside)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()

    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Propetries
    
    private func setupViews() {

        addSubview(headerLabel)
        addSubview(seeAllButton)

        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }

        seeAllButton.snp.makeConstraints { make in

            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(32)
        }
    }

    @objc private func tapSellAllButton() {
        print("tapSellAllButton")
    }
}
