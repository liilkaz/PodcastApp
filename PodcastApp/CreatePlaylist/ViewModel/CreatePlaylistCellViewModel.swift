//
//  CreatePlaylistCellViewModel.swift
//  PodcastApp
//
//  Created by sidzhe on 27.09.2023.
//

import Foundation

final class CreatePlaylistCellViewModel: CreatePlaylistCellProtocol {
    
    //MARK: - Properties
    
    private var favoritesModel: FavoritesModel
    
    var icon: String { favoritesModel.icon }
    
    var songName: String { favoritesModel.songName }
    
    var contentName: String { favoritesModel.contentName }
    
    //MARK: - Init

    init(favoritesModel: FavoritesModel) {
        self.favoritesModel = favoritesModel
    }
}
