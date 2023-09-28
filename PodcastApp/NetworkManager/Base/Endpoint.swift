//
//  Endpoint.swift
//  PodcastApp
//
//  Created by sidzhe on 28.09.2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String : String]? { get }
    var body: [String : String]? { get }
    var item: [URLQueryItem]? { get }
}

extension Endpoint {
    var scheme: String { "https" }
    var host: String { "api.podcastindex.org" }
}
