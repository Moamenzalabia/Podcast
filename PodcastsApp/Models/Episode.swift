//  Episode.swift
//  PodcastsApp
//  Created by MOAMEN on 9/10/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.

import Foundation
import FeedKit
struct Episode {
    
    let title: String?
    let pubDate: Date?
    let description: String?
    var imageUrl: String?
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.description ?? ""
        self.imageUrl = feedItem.iTunes?.iTunesImage?.attributes?.href
    }
}
