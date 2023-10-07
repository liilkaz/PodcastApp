import Foundation

class SearchResultViewModel {
    var networkService = NetworkService()
    var feeds = [Feed]()
    
    func fetchFeeds(with title: String, completion: @escaping () -> Void) {
        networkService.searchPodcastByTitle(title: title) { [weak self] (result: Result<Feeds, RequestError>) in
            switch result {
            case .success(let success):
                guard let model = success.feeds else { return }
                self?.feeds = model
                completion()
            case .failure(_):
                fatalError("Decode Error")
            }
        }
    }
}
