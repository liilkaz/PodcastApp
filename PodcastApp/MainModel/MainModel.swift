//
//  MainModel.swift
//  PodcastApp
//
//  Created by sidzhe on 28.09.2023.
//

import Foundation

//MARK: - MainModel

struct MainModel: Hashable, Decodable  {
    let status: String?
    let feeds: [Feed]?
    let count: Int?
    let query, description: String?
}

// MARK: - Feed
struct Feed: Hashable, Decodable  {
    let id: Int?
    let podcastGUID, title: String?
    let url, originalURL, link: String?
    let description, author, ownerName: String?
    let image, artwork: String?
    let lastUpdateTime, lastCrawlTime, lastParseTime, lastGoodHTTPStatusTime: Int?
    let lastHTTPStatus: Int?
    let contentType: String?
    let itunesID: Int?
    let generator, language: String?
    let explicit: Bool?
    let type: Int?
    let medium: String?
    let dead, episodeCount, crawlErrors, parseErrors: Int?
    let categories: [String: String]?
    let locked, imageURLHash, newestItemPubdate: Int?
}
