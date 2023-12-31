import UIKit

final class ProfileSettingViewControllerTableViewCell: UITableViewCell {
    
    //MARK: - Private Properties
    
    private lazy var iconContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlueColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var iconImageView = UIImageView()
    
    private lazy var menuTitleLabel = UILabel(textColor: .blackTextColor)
    
    private lazy var arrowImageView = UIImageView(image: UIImage(named: "arrowRight"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: PSModel) {
        iconImageView.image = UIImage(named: model.image)
        menuTitleLabel.text = model.menuText
    }
}

//MARK: - Extension PSViewControllerTableViewCell

private extension ProfileSettingViewControllerTableViewCell {
    
    func setupUI() {
        iconContentView.addSubviews(iconImageView)
        contentView.addSubviews(iconContentView, menuTitleLabel, arrowImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: iconContentView.topAnchor, constant: 12),
            iconImageView.leadingAnchor.constraint(equalTo: iconContentView.leadingAnchor, constant: 12),
            iconImageView.trailingAnchor.constraint(equalTo: iconContentView.trailingAnchor, constant: -12),
            iconImageView.bottomAnchor.constraint(equalTo: iconContentView.bottomAnchor, constant: -12),
            
            iconContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iconContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            
            menuTitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 25),
            menuTitleLabel.centerYAnchor.constraint(equalTo: iconContentView.centerYAnchor),
            
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: iconContentView.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}
