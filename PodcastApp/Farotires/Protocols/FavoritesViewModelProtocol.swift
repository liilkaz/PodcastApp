//
//  FavoritesViewModelProtocol.swift
//  PodcastApp
//
//  Created by sidzhe on 26.09.2023.
//

import Foundation

protocol FavoritesViewModelProtocol: AnyObject {
    func getRowsCount() -> Int
    func getModel(indexPath: IndexPath) -> FavoritsCellViewModelProtocol?
}
