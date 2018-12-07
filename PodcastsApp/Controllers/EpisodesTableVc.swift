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
    }
    
    //MARK: Setup Work
    fileprivate func setupTableView(){
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }

    //MARK: TableView
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
