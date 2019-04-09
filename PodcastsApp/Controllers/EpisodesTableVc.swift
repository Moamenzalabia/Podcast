//  EpisodesTableVc.swift
//  PodcastsApp
//  Created by MOAMEN on 9/10/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.

import UIKit
import FeedKit

class EpisodesTableVc: UITableViewController {
    
    fileprivate let cellId = "cellId"
    var episodes = [Episode]()
    
    var podcast: Podcast?{
        didSet {
            navigationItem.title = podcast?.trackName
            guard let stringUrl = podcast?.feedUrl else { return }
            fetchEpisodes(feedUrl: stringUrl)
        }
    }
    
    fileprivate func fetchEpisodes(feedUrl: String){
        
        APIService.shared.fetchEpisodes(feedUrl: feedUrl) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBarButtons()
    }
    
    fileprivate func setupNavigationBarButtons() {
        
        // let's check if we have already saved this podcast as Favorites
        
        let savedPodcasts = UserDefaults.standard.savedPodcasts()
        let hasFavorited = savedPodcasts.lastIndex(where: {$0.trackName == self.podcast?.trackName &&
            $0.artistName == self.podcast?.artistName}) != nil
        if hasFavorited {
            // setting up our heart icon
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "35 heart"), style: .plain, target: nil, action: nil)
        }else {
            navigationItem.rightBarButtonItems = [ UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(handleSaveFavorite))]
        }
        
    }
    
    @objc func handleSaveFavorite() {
        
        guard let podcast = self.podcast else { return}
        
        // 1- transform podcast into data
        // let data =  NSKeyedArchiver.archivedData(withRootObject: podcast)
        // UserDefaults.standard.set(data, forKey: favoritedPodcastKey)
        
        var listOfPodcast = UserDefaults.standard.savedPodcasts() // fetch our podcast first
        listOfPodcast.append(podcast)
        let data = try? NSKeyedArchiver.archivedData(withRootObject: listOfPodcast, requiringSecureCoding: false)
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritedPodcastKey)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "35 heart"), style: .plain, target: nil, action: nil)
        
        showBadgeHighlight()
    }
    
    fileprivate func showBadgeHighlight(){
        UIApplication.mainTabBarController()?.viewControllers?[1].tabBarItem.badgeValue = "New"
    }
    
    @objc func handleFetchSavedPodcasts() {
        
        // guard let data = UserDefaults.standard.data(forKey: favoritedPodcastKey) else { return }
        // let podcast = NSKeyedUnarchiver.unarchiveObject(with: data) as? Podcast
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.favoritedPodcastKey) else { return }
        let savePodcasts = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Podcast]
        
        savePodcasts??.forEach({ (podcast) in
            print(podcast.trackName ?? "")
        })
        
    }
    
    //MARK: Setup Work
    fileprivate func setupTableView(){
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK: TableView
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let downloadAction = UITableViewRowAction(style: .normal, title: "Download") { (_, _) in
            print("Downloading Episode into User Defaults ")
            UserDefaults.standard.downloadEpisode(episode: self.episodes[indexPath.row])
            
            // download episodse using alamofire
            APIService.shared.downloadEpisode(episode: self.episodes[indexPath.row])
            self.showDownloadBadgeHighlight()
            
        }
        
        return [downloadAction]
    }
    
    fileprivate func showDownloadBadgeHighlight(){
        UIApplication.mainTabBarController()?.viewControllers?[2].tabBarItem.badgeValue = "New"
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return episodes.isEmpty ? 200 : 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let episode = self.episodes[indexPath.row]
        let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        mainTabBarController?.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)
        /*
         let window = UIApplication.shared.keyWindow
         let playerDetailsView = PlayerDetailsView.initFromNib()
         playerDetailsView.episode = episode
         playerDetailsView.frame = self.view.frame
         window?.addSubview(playerDetailsView)
         */
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        cell.episode = episode
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
}
