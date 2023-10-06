import UIKit

protocol PlaylistViewModelProtocol: AnyObject {
    var eventHandler: ((Event) -> Void)? { get set }
    func getFavoritesModel(indexPath: IndexPath) -> FavoritsCellViewModelProtocol?
    func favoritesArray() -> [Item]?
    func getPlaylistModel(indexPath: IndexPath) -> FavoritsCellViewModelProtocol?
    func playlistArray() -> [Item]?
    func fetch()
    func getColorfull(_ index: Int) -> UIColor
}
