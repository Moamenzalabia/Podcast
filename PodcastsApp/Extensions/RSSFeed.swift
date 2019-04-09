//  RSSFeed.swift
//  PodcastsApp
//  Created by MOAMEN on 9/12/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.


import FeedKit

// this to get episodes array for itunes items it and it's image to display it in search tableview
extension RSSFeed {
    
    func toEpisodes() -> [Episode] {
        
        let imageUrl = iTunes?.iTunesImage?.attributes?.href
        
        var episodes = [Episode]()
        items?.forEach({ (feedItem) in
            var episode = Episode(feedItem: feedItem)
            
            if episode.imageUrl == nil {
                
                episode.imageUrl = imageUrl
                
            }
            episodes.append(episode)
        })
        return episodes
    }
    
}
