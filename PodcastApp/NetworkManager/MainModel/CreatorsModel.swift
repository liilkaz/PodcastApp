import Foundation

struct CreatorsModel: Decodable {
    let id: Int
    let title: String
    let enclosureUrl: String
    let duration: Int
    let episode: Int
    let image: String
    let feedAuthor: String
}
