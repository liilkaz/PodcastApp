//
//  PlaylistCellViewModel.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import Foundation

final class PlaylistCellViewModel: FavoritsCellViewModelProtocol {
    
    //MARK: - Properties
    
    private var favoritesModel: PodcastModel
    
    var icon: String { "" }
    
    var songName: String { "favoritesModel.songName" }
    
    var contentName: String { "favoritesModel.contentName" }
    
    //MARK: - Init

    init(favoritesModel: PodcastModel) {
        self.favoritesModel = favoritesModel
    }
}
