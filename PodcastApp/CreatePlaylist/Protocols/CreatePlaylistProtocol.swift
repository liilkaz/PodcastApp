//
//  CreatePlaylistProtocol.swift
//  PodcastApp
//
//  Created by sidzhe on 27.09.2023.
//

import Foundation

protocol CreatePlaylistProtocol: AnyObject {
    func getRowsCount() -> Int
    func getModel(_ indexPath: IndexPath) -> CreatePlaylistCellProtocol?
}
