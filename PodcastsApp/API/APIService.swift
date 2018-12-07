//  APIService.swift
//  PodcastsApp
//  Created by MOAMEN on 9/7/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.


import Foundation
import Alamofire
import FeedKit

class  APIService {
    
    let baseiTunesSearchURL = "https://itunes.apple.com/search"
    
    //singleton
    static let shared = APIService()
    
    func fetchEpisodes(feedUrl: String, completionHandler: @escaping ([Episode]) -> ()) {
        let secureFeedUrl = feedUrl.contains("https") ? feedUrl :
            feedUrl.replacingOccurrences(of: "http", with: "https")
        
        guard let url = URL(string: secureFeedUrl) else { return }
        let parser = FeedParser(URL: url)
        parser.parseAsync { (result) in
            if let error = result.error {
                print("Failed to parse XML feed:",error.localizedDescription)
                return
            }
            guard let feed = result.rssFeed else { return }
            let episode = feed.toEpisodes()
            completionHandler(episode)
        }
        
    }

    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        
        // later implement Alamofire to search iTunes API
        let parameters = ["term": searchText, "media": "podcast"]
        
        Alamofire.request(baseiTunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseData { (dataResponse) in
            
            if let error = dataResponse.error {
                print("Failed to contect with yahoo", error.localizedDescription)
                return
            }
            
            guard let data = dataResponse.data else { return }
            do {
                
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResult.results)
                
            }catch let decodeError {
                print("Failed to decode: ", decodeError)
            }
            
        }
    
    }
    
}
