//
//  TabBarVC.swift
//  PodcastApp
//
//  Created by Danila Bolshakov on 26.09.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    
    
    //MARK: - Generate TabBar
    
    private func generateTabBar() {
        let home = generateVC(viewController: UINavigationController(rootViewController: HomeViewController()), title: "House", image: UIImage(systemName: "house"))
        let search = generateVC(viewController: UINavigationController(rootViewController: SearchViewController()), title: "Search", image: UIImage(systemName: "magnifyingglass"))
        let favorites = generateVC(viewController: UINavigationController(rootViewController: PlaylistViewController()), title: "Favorites", image: UIImage(systemName: "bookmark"))
        let profile = generateVC(
            viewController: UINavigationController(rootViewController: ProfileSettingViewController()), title: "Settings",
                image: UIImage(systemName: "gearshape"))
        
        setViewControllers([home, search, favorites, profile], animated: true)
    }
    
    //MARK: - Generate VC
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        return viewController
    }
}
