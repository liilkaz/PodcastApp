import Foundation


struct Feeds: Decodable{
    let feeds: [Feed]?
}

// MARK: - Feed
struct Feed: Decodable {
    let id: Int?
    let title: String?
    let image: String?
    let episodeCount: Int?
}
