//
//  FavoritesListModel.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import UIKit

final class FavoritesListModel: FavoritsCellViewModelProtocol {
    
    //MARK: - Properties
    
    private var favoritesModel: Item
    
    var icon: String { "sdadsasdas" }
    
    var songName: String { "sdadsasdas" }
    
    var contentName: String { "sdadsasdas" }
    
    //MARK: - Init

    init(favoritesModel: Item) {
        self.favoritesModel = favoritesModel
    }
}
