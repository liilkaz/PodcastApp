import Foundation
import UIKit

class HomeViewModel {
    var categoryArray = CategoryMusic.allCases.map { $0 }
    var categoryImageArray = [#imageLiteral(resourceName: "classical"), #imageLiteral(resourceName: "holiday"), #imageLiteral(resourceName: "jazz"), #imageLiteral(resourceName: "pop"), #imageLiteral(resourceName: "childrens"), #imageLiteral(resourceName: "world"), #imageLiteral(resourceName: "hiphop"), #imageLiteral(resourceName: "rock"), #imageLiteral(resourceName: "electronic")]
}
