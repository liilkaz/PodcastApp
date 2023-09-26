//
//  PlaylistViewModelProtocol.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import Foundation

protocol PlaylistViewModelProtocol: AnyObject {
    func getFavoritesModel(indexPath: IndexPath) -> FavoritsCellViewModelProtocol?
    func favoritesArray() -> [FavoritesModel]? 
}
