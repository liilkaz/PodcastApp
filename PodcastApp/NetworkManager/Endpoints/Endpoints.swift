//
//  Endpoints.swift
//  PodcastApp
//
//  Created by sidzhe on 03.10.2023.
//

import Foundation

//MARK: - Podcast endpoints

enum PodcastEndpoint {
    case serchPodcast
    case recent
}


//MARK: - Extension PodcastEndpoint

extension PodcastEndpoint: Endpoint {
    
    var path: String {
        switch self {
            
        case .serchPodcast:
            return "/api/1.0/search/byperson"
        case .recent:
            return "/api/1.0/recent/episodes"
        }
    }
    
    var method: RequestMethod {
        switch self {
            
        case .serchPodcast:
            return .get
        case .recent:
            return .get
        }
    }
    
    var header: [String : String]? {
        switch self {
            
        case .serchPodcast:
            
            let apiKey = "WXBZTQWQCKQKZVEVPYKT"
            let apiSecret = "PEWevq^7z^a4bjafR$#EnGe8#98$WuMH599T#4Kg"
            let apiHeaderTime = String(Int(Date().timeIntervalSince1970))
            let hash = (apiKey + apiSecret + apiHeaderTime).sha1()
            
            let headers: [String: String] = [
                   "User-Agent": "com.tacarlen.Podcast-App",
                   "X-Auth-Key": apiKey,
                   "X-Auth-Date": apiHeaderTime,
                   "Authorization": hash
               ]
            
            return headers
            
        case .recent:
            let apiKey = "WXBZTQWQCKQKZVEVPYKT"
            let apiSecret = "PEWevq^7z^a4bjafR$#EnGe8#98$WuMH599T#4Kg"
            let apiHeaderTime = String(Int(Date().timeIntervalSince1970))
            let hash = (apiKey + apiSecret + apiHeaderTime).sha1()

            let headers: [String: String] = [
                   "User-Agent": "com.tacarlen.Podcast-App",
                   "X-Auth-Key": apiKey,
                   "X-Auth-Date": apiHeaderTime,
                   "Authorization": hash
               ]
            
            return headers
        }
    }
    
    var body: [String : String]? {
        switch self {
            
        case .serchPodcast:
            return nil
        case .recent:
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
        }
    }
}
