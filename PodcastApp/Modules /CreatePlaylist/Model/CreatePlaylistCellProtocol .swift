import UIKit

protocol CreatePlaylistCellProtocol: AnyObject {
    var icon: ObserverBox<UIImage?> { get set }
    var songName: String { get }
    var contentName: String { get }
}
