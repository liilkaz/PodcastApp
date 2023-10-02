//
//  PlaylistModel.swift
//  PodcastApp
//
//  Created by sidzhe on 02.10.2023.
//

import Foundation

struct PlaylistModel: Hashable {
    var favorites: Item?
    var playlist: Item?
    let identifier = UUID()
}
