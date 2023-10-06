import Foundation

struct PlaylistModel: Hashable {
    var favorites: Item?
    var playlist: Item?
    let identifier = UUID()
}
