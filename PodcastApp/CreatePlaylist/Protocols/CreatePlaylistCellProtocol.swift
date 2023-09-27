//
//  CreatePlaylistCellProtocol.swift
//  PodcastApp
//
//  Created by sidzhe on 27.09.2023.
//

import Foundation

protocol CreatePlaylistCellProtocol: AnyObject {
    var icon: String { get }
    var songName: String { get }
    var contentName: String { get }
}
