//
//  FavoritesViewModel.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import UIKit

final class FavoritesViewModel: FavoritesViewModelProtocol {
    
    private let model = [FavoritesModel]()
    
    func getRowsCount() -> Int {
        return model.count
    }
    
    func getModel(indexPath: IndexPath) -> FavoritsCellViewModelProtocol? {
        let model = model[indexPath.row]
        return FavoritsCellViewModel(favoritesModel: model)
    }
}
