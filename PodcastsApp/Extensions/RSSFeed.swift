//  RSSFeed.swift
//  PodcastsApp
//  Created by MOAMEN on 9/12/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.


import FeedKit

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
