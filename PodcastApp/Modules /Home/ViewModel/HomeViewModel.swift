import Foundation
import UIKit

class HomeViewModel {
    var networkService = NetworkService()
    var categoryArray = CategoryMusic.allCases.map { $0 }
    var categoryTagArray = PopularCreators.allCases.map { $0.rawValue }
    var categoryImageArray = [#imageLiteral(resourceName: "Arts"), #imageLiteral(resourceName: "books"), #imageLiteral(resourceName: "design"), #imageLiteral(resourceName: "fashion"), #imageLiteral(resourceName: "beauty"), #imageLiteral(resourceName: "food"), #imageLiteral(resourceName: "performing"), #imageLiteral(resourceName: "visual"), #imageLiteral(resourceName: "business"), #imageLiteral(resourceName: "career"), #imageLiteral(resourceName: "entrepreneurship"), #imageLiteral(resourceName: "investing"), #imageLiteral(resourceName: "management"), #imageLiteral(resourceName: "marketing"), #imageLiteral(resourceName: "non-profit"), #imageLiteral(resourceName: "comedy"), #imageLiteral(resourceName: "interviews"), #imageLiteral(resourceName: "improv"), #imageLiteral(resourceName: "stand-up"), #imageLiteral(resourceName: "education")]
    var creatorsArray = [Item]()
    
    func fetchPodcast(creator: String, completion: @escaping (Result <[Item], RequestError>) -> Void) {
        networkService.searchPodcast(search: creator) { [weak self] (result: Result<PodcastModel, RequestError>) in
            switch result {
            case .success(let success):
                guard let model = success.items else { return }
                self?.creatorsArray = model
                completion(.success(model))
            case .failure(let failure):
                print(failure.localizedDescription)
                completion(.failure(failure))
            }
        }
    }
}

