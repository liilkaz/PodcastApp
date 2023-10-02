import UIKit

class MusicButton: UIButton {
    init(image: UIImage?, selector: Selector) {
        super.init(frame: .zero)
        self.tintColor = .black
        self.setImage(image, for: .normal)
        self.addTarget(self, action: selector, for: .touchUpInside)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
