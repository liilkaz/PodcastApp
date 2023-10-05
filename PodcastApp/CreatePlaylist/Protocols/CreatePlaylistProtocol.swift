//
//  CreatePlaylistProtocol.swift
//  PodcastApp
//
//  Created by sidzhe on 05.10.2023.
//

import UIKit

protocol CreatePlaylistProtocol: AnyObject {
    var eventHandler: ((_ event: Event) -> Void)? { get set }
    func getRowsCount() -> Int
    func getModel(_ indexPath: IndexPath) -> CreatePlaylistCellProtocol?
    func fetch()
    func searchRequest(_ search: String?)
    func savePlaylist(playlistName: String?, icon: UIImage?)
    func addIndex(state: Bool, index: Int)
}
