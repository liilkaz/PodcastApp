import Foundation

class ChannelViewModel {
    var channelModel: ChannelModel
    var networkService = NetworkService()
    var channelItem = [Feed]()
    
    init(channelModel: ChannelModel) {
        self.channelModel = channelModel
    }
    
    
    func fetchPodcast(with category: String, completion: @escaping (Result<[Feed], RequestError>) -> Void) {
        print(category)
        networkService.searchPodcastByTitle(title: category) { (result: Result<Feeds, RequestError>) in
            switch result {
            case .success(let success):
                guard let model = success.feeds else { return }
                self.channelItem = model
                completion(.success(model))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}


// https://api.podcastindex.org/api/1.0/search/bytitle?q=Arts&max=10&pretty
//  https://api.podcastindex.org/api/1.0/search/bytitle?q=everything+everywhere+daily&pretty

