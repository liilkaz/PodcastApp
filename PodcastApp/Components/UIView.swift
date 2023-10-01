import UIKit

class CornerRadiusUIView: UIView {
    init(background: UIColor?, rounding: CGFloat){
        super.init(frame: .zero)
        self.backgroundColor = background
        self.layer.cornerRadius = rounding
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
