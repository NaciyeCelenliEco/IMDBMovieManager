//
//  TabBarViewController.swift
//  MovieManager
//
//  Created by Naciye Celenli on 6.02.2022.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidAppear(_ animated: Bool) {
        self.selectedIndex = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor =  UIColor(red: 186/255.0, green: 186/255.0, blue: 186/255.0, alpha: 1.0)
        
        let search = NavigationController(rootViewController: SearchViewController())
        let watchlist = NavigationController(rootViewController: WatchlistViewController())
        let favorites = NavigationController(rootViewController: FavoritesViewController())
        
        
        let searchTabbarItem = UITabBarItem(title: "Search", image: UIImage(named: "camera")!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "camera_selected")!.withRenderingMode(.alwaysOriginal))
        let watchTabbarItem = UITabBarItem(title: "Watchlist", image: UIImage(named: "list")!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "list_selected")!.withRenderingMode(.alwaysOriginal))
        let favTabbarItem = UITabBarItem(title: "Favorites", image: UIImage(named: "heart")!.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "heart_selected")!.withRenderingMode(.alwaysOriginal))
        
        
        search.tabBarItem = searchTabbarItem
        watchlist.tabBarItem = watchTabbarItem
        favorites.tabBarItem = favTabbarItem
        
        viewControllers = [search, watchlist, favorites]
    }
    
}

