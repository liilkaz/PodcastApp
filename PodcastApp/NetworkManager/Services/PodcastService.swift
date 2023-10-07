import Foundation

//MARK: - Podcast Service

struct PodcastService: PodcastClient, Serviceable {
    func getPodcastByTitle<T: Decodable>(title: String) async -> Result<T, RequestError>  {
        return await sendRequestByTitle(endpoint: PodcastEndpoint.bytitle, responseModel: T.self, title: title)
    }
    
    
    func getPodcast<T: Decodable>(search: String) async -> Result<T, RequestError> {
        return await sendRequest(endpoint: PodcastEndpoint.serchPodcast, responseModel: T.self, search: search)
    }
    
    func getRecent<T: Decodable>() async -> Result<T, RequestError> {
        return await sendRecentRequest(endpoint: PodcastEndpoint.recent, responseModel: T.self)
    }
}

