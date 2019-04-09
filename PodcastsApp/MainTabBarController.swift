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
        setupPlayerDetailsView()
        
    }
    
    @objc func minimizePlayerDetails() {
        maximizedTopAnchorConstraint.isActive = false
        bottomAnchorConstraint.constant = view.frame.height
        minimizedTopAnchorConstraint.isActive = true
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.transform = .identity
            self.playerDetailsView.maximizedStackView.alpha = 0
            self.playerDetailsView.miniPlayerView.alpha = 1
        })
    }
    
    func maximizePlayerDetails(episode: Episode?, playlistEpisodes: [Episode] = [] ) {
        
        minimizedTopAnchorConstraint.isActive = false
        maximizedTopAnchorConstraint.isActive = true
        maximizedTopAnchorConstraint.constant = 0
        
        bottomAnchorConstraint.constant = 0
        
        if episode != nil {
            playerDetailsView.episode = episode
        }
        
        playerDetailsView.playlistEpisode = playlistEpisodes
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.tabBar.transform = CGAffineTransform.init(translationX: 0, y: 100)
            self.playerDetailsView.maximizedStackView.alpha = 1
            self.playerDetailsView.miniPlayerView.alpha = 0
        })
        
    }
    
     //MARK:- Setup Functions
    let playerDetailsView = PlayerDetailsView.initFromNib()
    var maximizedTopAnchorConstraint: NSLayoutConstraint!
    var minimizedTopAnchorConstraint: NSLayoutConstraint!
    var bottomAnchorConstraint: NSLayoutConstraint!
    
    fileprivate func setupPlayerDetailsView() {
        
        //use auto layout
        view.insertSubview(playerDetailsView, belowSubview: tabBar)
        
        // enable auto layout for Player Details View
        playerDetailsView.translatesAutoresizingMaskIntoConstraints = false
        maximizedTopAnchorConstraint =  playerDetailsView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height)
        maximizedTopAnchorConstraint.isActive = true
        bottomAnchorConstraint = playerDetailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height)
        bottomAnchorConstraint.isActive = true
        minimizedTopAnchorConstraint = playerDetailsView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -64) // to leave -64 pixel above tabbar to Player Details View
        playerDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
    }
    
    // setup TabBar ViewController's
    fileprivate func setupViewController() {
        
        let layout = UICollectionViewFlowLayout()
        let favoritesController = FavoriteController(collectionViewLayout: layout)
        
        let favoriteNavController = generateNavigationController(withRootViewController: favoritesController, title: "Favorites", image: #imageLiteral(resourceName: "favorites"))
        let searchNavController = generateNavigationController(withRootViewController: SearchTableVC(), title: "Search", image: #imageLiteral(resourceName: "search"))
        let downloadsNavController = generateNavigationController(withRootViewController: DownloadVC(), title: "Downloads", image: #imageLiteral(resourceName: "downloads"))
        
        viewControllers = [searchNavController, favoriteNavController, downloadsNavController]
    }
    
    //MARK:- Helper Functions that's generate Navigation Controller
    fileprivate func generateNavigationController(withRootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: withRootViewController)
        withRootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        
       return navController
    }

}
