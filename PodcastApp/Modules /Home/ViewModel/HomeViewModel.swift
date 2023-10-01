import Foundation
import UIKit

class HomeViewModel {
    var categoryArray = CategoryMusic.allCases.map { $0 }
    var categoryImageArray = [#imageLiteral(resourceName: "Arts"), #imageLiteral(resourceName: "books"), #imageLiteral(resourceName: "design"), #imageLiteral(resourceName: "fashion"), #imageLiteral(resourceName: "beauty"), #imageLiteral(resourceName: "food"), #imageLiteral(resourceName: "performing"), #imageLiteral(resourceName: "visual"), #imageLiteral(resourceName: "business"), #imageLiteral(resourceName: "career"), #imageLiteral(resourceName: "entrepreneurship"), #imageLiteral(resourceName: "investing"), #imageLiteral(resourceName: "management"), #imageLiteral(resourceName: "marketing"), #imageLiteral(resourceName: "non-profit"), #imageLiteral(resourceName: "comedy"), #imageLiteral(resourceName: "interviews"), #imageLiteral(resourceName: "improv"), #imageLiteral(resourceName: "stand-up"), #imageLiteral(resourceName: "education")]
}

