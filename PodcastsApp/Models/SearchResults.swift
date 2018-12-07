//  SearchResults.swift
//  PodcastsApp
//  Created by MOAMEN on 9/6/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.

import Foundation

struct SearchResults: Decodable {
    
    let resultCount: Int
    let results: [Podcast]
    
}
