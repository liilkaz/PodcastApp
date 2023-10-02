//
//  FavoritsCellViewModel.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import UIKit

final class FavoritsCellViewModel: FavoritsCellViewModelProtocol {
    
    //MARK: - Properties
    
    private var favoritesModel: Item
    
    var icon: String { "favoritesModel.icon" }
    
    var songName: String { "favoritesModel.songName" }
    
    var contentName: String { "favoritesModel.contentName" }
    
    //MARK: - Init

    init(favoritesModel: Item) {
        self.favoritesModel = favoritesModel
    }
}
