import UIKit
import SnapKit

final class HeaderCell: UICollectionReusableView {

    //MARK: - UI Elements
    
    private lazy var headerLabel = UILabel(text: "Favorites", font: .jakarta16semibold(),textColor: .blackTextColor, textAlignment: .center)

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

        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
    }

    @objc private func tapSellAllButton() {
        print("tapSellAllButton")
    }
}
