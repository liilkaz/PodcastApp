//
//  FhirdVC.swift
//  PodcastApp
//
//  Created by iOS - Developer on 25.09.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var realmDataBase = RealmService()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGrayWallpaper
        navigationItem.title = "Favorites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchFavoritesPodcast()
    }
    
    func fetchFavoritesPodcast() {
        print(realmDataBase.loadFavoritesPodcastFromRealm())
    }
}
