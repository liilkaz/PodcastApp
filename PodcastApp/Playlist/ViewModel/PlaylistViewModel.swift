//
//  PlaylistViewModel.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import UIKit

final class PlaylistViewModel: PlaylistViewModelProtocol {

    //MARK: - Properties
    
    var eventHandler: ((Event) -> Void)?
    private var favoritesModel: [Item]?
    private var playlistModel: [Item]?
    private var networkService = NetworkService()
    
    //MARK: - Methods
    
    func getFavoritesRows() -> Int {
        return favoritesModel?.count ?? 0
    }
    
    func getFavoritesModel(indexPath: IndexPath) -> FavoritsCellViewModelProtocol? {
        guard let model = favoritesModel?[indexPath.row] else { return nil }
        return FavoritsCellViewModel(favoritesModel: model)
    }
    
    func favoritesArray() -> [Item]? {
        return favoritesModel
    }
    
    func getPlaylistModel(indexPath: IndexPath) -> FavoritsCellViewModelProtocol? {
        guard let model = playlistModel?[indexPath.row] else { return nil }
        return FavoritesListModel(favoritesModel: model)
    }
    
    func playlistArray() -> [Item]? {
        return playlistModel
    }
    
    func fetch() {
        
        self.eventHandler?(.loading)
        
        networkService.searchRecent { [weak self] (result: Result<PodcastModel, RequestError>) in
            print("TYT")
            guard let self else { return }
            
            self.eventHandler?(.stopLoading)
            
            switch result {
            
            case .success(let data):
                guard let item = data.items else { return }
                self.favoritesModel = item
                self.playlistModel = item
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }}
