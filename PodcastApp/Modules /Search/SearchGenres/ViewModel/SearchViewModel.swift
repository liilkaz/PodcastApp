import Foundation

class SearchViewModel {
    var networkService = NetworkService()
    var result = [Feed]()
    
    func request(for title: String, completion: @escaping (Result<[Feed], RequestError>) -> Void){
        networkService.searchPodcastByTitle(title: title) { (result: Result<Feeds, RequestError>) in
            switch result {
            case .success(let success):
                guard let model = success.feeds else { return }
                self.result = model
                completion(.success(model))
            case .failure(_):
                completion(.failure(.invalidURL))
            }
        }
    }
}
