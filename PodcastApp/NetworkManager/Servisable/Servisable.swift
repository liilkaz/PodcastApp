import Foundation

//MARK: - Protocol Servisable

protocol Serviceable {
    func getPodcast<T: Decodable>(search: String) async -> Result<T, RequestError>
    func getPodcastByTitle<T: Decodable>(title: String) async -> Result<T,RequestError>
    func getRecent<T: Decodable>() async -> Result<T, RequestError>
}
