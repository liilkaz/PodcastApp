//
//  Endpoints.swift
//  PodcastApp
//
//  Created by sidzhe on 28.09.2023.
//

import Foundation

//MARK: - Podcast endpoints

enum PodcastEndpoint {
    case serchPodcast
}


//MARK: - Extension PodcastEndpoint

extension PodcastEndpoint: Endpoint {
    
    var path: String {
        switch self {
            
        case .serchPodcast: 
            return "/api/1.0/search/byterm"
        }
    }
    
    var method: RequestMethod {
        switch self {
            
        case .serchPodcast:
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
        }
    }
    
    var body: [String : String]? {
        switch self {
            
        case .serchPodcast:
            return nil
        }
    }
    
    var item: [URLQueryItem]? {
        switch self {
            
        case .serchPodcast:
            return nil
        }
    }
}
