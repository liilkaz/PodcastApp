import Foundation

// MARK: - Podcast endpoints

enum PodcastEndpoint {
    case serchPodcast
    case recent
    case bytitle
}

// MARK: - Extension PodcastEndpoint

extension PodcastEndpoint: Endpoint {
    var path: String {
        switch self {
        case .serchPodcast:
            return "/api/1.0/search/byperson"
        case .recent:
            return "/api/1.0/recent/episodes"
        case .bytitle:
            return "/api/1.0/search/bytitle"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .serchPodcast:
            return .get
        case .recent:
            return .get
        case .bytitle:
            return .get
        }
    }
    
    var header: [String: String]? {
        let apiKey = "WXBZTQWQCKQKZVEVPYKT"
        let apiSecret = "PEWevq^7z^a4bjafR$#EnGe8#98$WuMH599T#4Kg"
        let apiHeaderTime = String(Int(Date().timeIntervalSince1970))
        let hash = (apiKey + apiSecret + apiHeaderTime).sha1()
        switch self {
        case .serchPodcast:
            let headers: [String: String] = [
                "User-Agent": "com.tacarlen.Podcast-App",
                "X-Auth-Key": apiKey,
                "X-Auth-Date": apiHeaderTime,
                "Authorization": hash
            ]
            return headers
            
        case .recent:
            let headers: [String: String] = [
                "User-Agent": "com.tacarlen.Podcast-App",
                "X-Auth-Key": apiKey,
                "X-Auth-Date": apiHeaderTime,
                "Authorization": hash
            ]
            return headers
        case .bytitle:
            let headers: [String: String] = [
                "User-Agent": "com.tacarlen.Podcast-App",
                "X-Auth-Key": apiKey,
                "X-Auth-Date": apiHeaderTime,
                "Authorization": hash
            ]
            return headers
        }
    }
    
    var body: [String: String]? {
        switch self {
        case .serchPodcast:
            return nil
        case .recent:
            return nil
        case .bytitle:
            return nil
        }
    }
    
    var item: [URLQueryItem]? {
        switch self {
        case .serchPodcast:
            return nil
        case .recent:
            let items = [URLQueryItem(name: "max", value: "7"), URLQueryItem(name: "pretty", value: nil)]
            return items
        case .bytitle:
            let items = [URLQueryItem(name: "max", value: "10"), URLQueryItem(name: "pretty", value: nil)]
            return items
        }
    }
}
