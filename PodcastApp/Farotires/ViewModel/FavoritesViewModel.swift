//
//  FavoritesViewModel.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import UIKit

final class FavoritesViewModel: FavoritesViewModelProtocol {
    
    private let model = [FavoritesModel(icon: "swift", songName: "song name1", contentName: "contentName1"),
                         FavoritesModel(icon: "swift", songName: "song name2", contentName: "contentName2"),
                         FavoritesModel(icon: "swift", songName: "song name3", contentName: "contentName3"),
                         FavoritesModel(icon: "swift", songName: "song name4", contentName: "contentName4"),
                         FavoritesModel(icon: "swift", songName: "song name5", contentName: "contentName5"),
                         FavoritesModel(icon: "swift", songName: "song name6", contentName: "contentName6")]
    
    func getRowsCount() -> Int {
        return model.count
    }
    
    func getModel(indexPath: IndexPath) -> FavoritsCellViewModelProtocol? {
        let model = model[indexPath.row]
        return FavoritsCellViewModel(favoritesModel: model)
    }
}
