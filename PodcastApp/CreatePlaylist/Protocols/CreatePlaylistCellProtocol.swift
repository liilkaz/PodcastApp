//
//  CreatePlaylistCellProtocol.swift
//  PodcastApp
//
//  Created by sidzhe on 27.09.2023.
//

import UIKit

protocol CreatePlaylistCellProtocol: AnyObject {
    var icon: ObserverBox<UIImage?> { get set }
    var songName: String { get }
    var contentName: String { get }
}
