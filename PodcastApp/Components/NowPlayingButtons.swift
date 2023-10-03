import UIKit

class NowPlayingButtons: UIButton {
    let config: UIImage.SymbolConfiguration
    init(pointSize: CGFloat, image: UIImage?) {
        self.config = UIImage.SymbolConfiguration(pointSize: pointSize)
        super.init(frame: .zero)
        self.setImage(image?.withConfiguration(config), for: .normal)
        self.tintColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
