import Foundation
import UIKit

extension UICollectionView {
    convenience init(dataSource: UICollectionViewDataSource?, delegate: UICollectionViewDelegate?, width: Int, height: Int) {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        flow.itemSize = CGSize(width: width, height: height)
        self.init(frame: .zero, collectionViewLayout: flow)
        self.allowsMultipleSelection = true
        self.dataSource = dataSource
        self.delegate = delegate
        self.showsHorizontalScrollIndicator = false
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
