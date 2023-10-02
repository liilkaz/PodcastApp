import UIKit

extension UIButton {
    
    convenience init(
        title: String,
        backgroundColor: UIColor?,
        titleColor: UIColor,
        font: UIFont? = .jakarta16semibold(),
        hasBorder: Bool,
        cornerRadius: CGFloat = 4) {
            self.init(type: .system)
            self.setTitle(title, for: .normal)
            self.setTitleColor(titleColor, for: .normal)
            self.backgroundColor = backgroundColor
            self.titleLabel?.font = font
            self.layer.cornerRadius = cornerRadius
            
            if hasBorder {
                self.layer.borderWidth = 1
                self.layer.borderColor = titleColor.cgColor
            }
        }
    
    func setupGoogleImage() {
        let image = UIImageView(image: UIImage(named: "googleImage") ?? UIImage())
        image.contentMode = .scaleAspectFit
        
        self.addSubviews(image)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 60),
            image.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    //MARK: - To edit a profile photo
    
    func setupImage(_ image: UIImage?) {
        let image = UIImageView(image: image ?? UIImage())
        image.contentMode = .scaleAspectFit
        
        addSubviews(image)
        
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18),
            image.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}






extension UIButton {
    convenience init(text: String?, textColor: UIColor?, backgroundColor: UIColor?, cornerRadius: CGFloat = 0) {
        self.init()
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
