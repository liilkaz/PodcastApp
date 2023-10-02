//
//  PodcastModel.swift
//  PodcastApp
//
//  Created by sidzhe on 28.09.2023.
//

import Foundation

// MARK: - PodcastModel

struct PodcastModel: Hashable, Decodable {
    let status: String?
    let items: [Item]?
    let count: Int?
    let query, description: String?
}

// MARK: - Item
struct Item: Hashable, Decodable {
    let id: Int?
    let title: String?
    let link: String?
    let description, guid: String?
    let datePublished, dateCrawled: Int?
    let enclosureURL: String?
    let enclosureType: String?
    let enclosureLength, duration, explicit, episode: Int?
    let episodeType: String?
    let season: Int?
    let image: String?
    let feedItunesID: Int?
    let feedImage: String?
    let feedID: Int?
    let feedURL: String?
    let feedAuthor, feedTitle, feedLanguage: String?
    let chaptersURL: String?
    let transcriptURL: String?
    let transcripts: [Transcript]?

    enum CodingKeys: String, CodingKey {
        case id, title, link, description, guid, datePublished, dateCrawled
        case enclosureURL = "enclosureUrl"
        case enclosureType, enclosureLength, duration, explicit, episode, episodeType, season, image
        case feedItunesID = "feedItunesId"
        case feedImage
        case feedID = "feedId"
        case feedURL = "feedUrl"
        case feedAuthor, feedTitle, feedLanguage
        case chaptersURL = "chaptersUrl"
        case transcriptURL = "transcriptUrl"
        case transcripts
    }
}

// MARK: - Transcript
struct Transcript: Hashable, Decodable {
    let url: String?
    let type: String?
}
