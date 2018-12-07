//  MainTabBarController.swift
//  PodcastsApp
//  Created by MOAMEN on 9/5/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.gray
        tabBar.tintColor = UIColor.purple
        UINavigationBar.appearance().prefersLargeTitles = true
        
        setupViewController()
    
    }
    
     //MARK:- Setup Functions
    fileprivate func setupViewController() {
        
        let favoriteNavController = generateNavigationController(withRootViewController: FavoriteVC(), title: "Favorites", image: #imageLiteral(resourceName: "favorites"))
        let searchNavController = generateNavigationController(withRootViewController: SearchTableVC(), title: "Search", image: #imageLiteral(resourceName: "search"))
        let downloadsNavController = generateNavigationController(withRootViewController: FavoriteVC(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        
        viewControllers = [searchNavController, favoriteNavController, downloadsNavController]
    }
    
    //MARK:- Helper Functions
    fileprivate func generateNavigationController(withRootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: withRootViewController)
       // navController.navigationBar.prefersLargeTitles = true
        withRootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
       return navController
    }

}
