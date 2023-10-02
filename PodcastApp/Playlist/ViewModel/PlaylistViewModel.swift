//
//  PlaylistViewModel.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import UIKit

final class PlaylistViewModel: PlaylistViewModelProtocol {

    //MARK: - Properties
    
    private var favoritesModel = [FavoritesModel(icon: "swift", songName: "song name1", contentName: "contentName1")]
    
    private var playlistModel = [FavoritesModel(icon: "swift", songName: "song name1", contentName: "contentName1"),
                                 FavoritesModel(icon: "swift", songName: "song name2", contentName: "contentName2"),
                                 FavoritesModel(icon: "swift", songName: "song name3", contentName: "contentName3"),
                                 FavoritesModel(icon: "swift", songName: "song name4", contentName: "contentName4"),
                                 FavoritesModel(icon: "swift", songName: "song name5", contentName: "contentName5"),
                                 FavoritesModel(icon: "swift", songName: "song name6", contentName: "contentName6"),
                                 FavoritesModel(icon: "swift", songName: "song name7", contentName: "contentName7"),
                                 FavoritesModel(icon: "swift", songName: "song name8", contentName: "contentName8"),
                                 FavoritesModel(icon: "swift", songName: "song name9", contentName: "contentName9"),
                                 FavoritesModel(icon: "swift", songName: "song name10", contentName: "contentName10")]
    
    //MARK: - Methods
    
    func getFavoritesRows() -> Int {
        return favoritesModel.count
    }
    
    func getFavoritesModel(indexPath: IndexPath) -> FavoritsCellViewModelProtocol? {
        let model = favoritesModel[indexPath.row]
        return FavoritsCellViewModel(favoritesModel: model)
    }
    
    func favoritesArray() -> [FavoritesModel]? {
        return favoritesModel
    }
    
    func getPlaylistModel(indexPath: IndexPath) -> FavoritsCellViewModelProtocol? {
        let model = playlistModel[indexPath.row]
        return FavoritesListModel(favoritesModel: model)
    }
    
    func playlistArray() -> [FavoritesModel]? {
        return playlistModel
    }
}
