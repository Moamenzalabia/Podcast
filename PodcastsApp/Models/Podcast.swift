//  Podcast.swift
//  PodcastsApp
//  Created by MOAMEN on 9/6/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.

import Foundation

// podcast model 
class Podcast: NSObject, Decodable, NSCoding {
    
    var trackName: String?
    var artistName: String?
    var artworkUrl60: String?
    var trackCount: Int?
    var feedUrl: String?
    
    func encode(with aCoder: NSCoder) {
        
        print("Trying to transform Podcast into Data")
        aCoder.encode(trackName ?? "", forKey: "trackNameKey")
        aCoder.encode(artistName ?? "", forKey: "artistNameKey")
        aCoder.encode(artworkUrl60 ?? "", forKey: "artworkUrl60Key")
        aCoder.encode(trackCount ?? "", forKey: "trackCountKey")
        aCoder.encode(feedUrl ?? "", forKey: "feedUrlKey")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        print("Trying to turn Data into Podcast")
        self.trackName = aDecoder.decodeObject(forKey: "trackNameKey") as? String
        self.artistName = aDecoder.decodeObject(forKey: "artistNameKey") as? String
        self.artworkUrl60 = aDecoder.decodeObject(forKey: "artworkUrl60Key") as? String
        self.trackCount = aDecoder.decodeObject(forKey: "trackCountKey") as? Int
        self.feedUrl = aDecoder.decodeObject(forKey: "feedUrlKey") as? String
        
    }
    
}
