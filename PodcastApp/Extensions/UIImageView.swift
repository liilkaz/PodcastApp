import UIKit

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init()
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
