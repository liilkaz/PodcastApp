import UIKit

extension UIView {
    convenience init(background: UIColor, cornerRadius: CGFloat) {
        self.init(frame: .zero)
        self.backgroundColor = background
        self.layer.cornerRadius = cornerRadius
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
