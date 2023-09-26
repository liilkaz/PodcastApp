//
//  FavoritsCellViewModelProtocol.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import Foundation

protocol FavoritsCellViewModelProtocol: AnyObject {
    var icon: String { get }
    var songName: String { get }
    var contentName: String  { get }
}
