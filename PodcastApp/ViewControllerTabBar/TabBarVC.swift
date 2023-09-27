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
        setTabBarAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = 2
    }
    
    //MARK: - Generate TabBar
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: HomeVC(),
                image: UIImage(named: "home")),
            generateVC(
                viewController: SearchVC(),
                image: UIImage(named: "search")),
            generateVC(
                viewController: FavoritesVC(),
                image: UIImage(named: "bookmark")),
            generateVC(
                viewController: ProfileSettingVC(),
                image: UIImage(named: "setting"))
        ]
    }
    
    //MARK: - Generate VC
    
    private func generateVC(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
    
    //MARK: - Set TabBar Appearance
    
    private func  setTabBarAppearance() {
        let positionOnX: CGFloat = 5
        let positionOnY: CGFloat = 3
        
        let width = tabBar.bounds.width - positionOnX * 15
        let hight = tabBar.bounds.height + positionOnY * 1
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect:
                CGRect(
                    x: CGFloat(Int(tabBar.bounds.minX + 35)),
                    y: CGFloat(Int(tabBar.bounds.minY - 5)),
                    width: width,
                    height: hight
                ),
            cornerRadius: hight / 4
        )
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.layer.shadowRadius = 10

        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.tintColor = .tabBarItemLight
    }
}
