//
//  FavoritesListModel.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import UIKit

final class FavoritesListModel: FavoritsCellViewModelProtocol {
    
    //MARK: - Properties
    
    private var favoritesModel: FavoritesModel
    
    var icon: String { "" }
    
    var songName: String { "" }
    
    var contentName: String { "" }
    
    //MARK: - Init

    init(favoritesModel: FavoritesModel) {
        self.favoritesModel = favoritesModel
    }
}
