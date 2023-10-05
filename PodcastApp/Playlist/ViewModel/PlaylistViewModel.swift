//
//  PlaylistViewModel.swift
//  PodcastApp
//
//  Created by sidzhe on 05.10.2023.
//

import UIKit

final class PlaylistViewModel: PlaylistViewModelProtocol {
    
    //MARK: - Properties
    
    var eventHandler: ((Event) -> Void)?
    private var favoritesModel: [Item]?
    private var playlistModel: [Item]?
    private var networkService = NetworkService()
    private let cellColors = [UIColor.customBlue, UIColor.customLightBlue, UIColor.customPink]
    private var cellColorIndexMap: [Int: Int] = [:]
    
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
    
    func getColorfull(_ index: Int) -> UIColor {
        
        let colorIndex = index % cellColors.count
        cellColorIndexMap[index] = colorIndex
        return cellColors[colorIndex]
    }
    
    func fetch() {
        
        networkService.searchRecent { [weak self] (result: Result<PodcastModel, RequestError>) in
            
            guard let self else { return }
            
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
    }
}
