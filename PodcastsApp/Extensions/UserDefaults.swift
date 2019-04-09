//  UserDefaults.swift
//  PodcastsApp
//  Created by MOAMEN on 12/26/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.

import Foundation

extension UserDefaults{
    
    static let favoritedPodcastKey = "favoritedPodcastKey"
    static let downloadedEpisodesKey = "downloadedEpisodesKey"
    
    // if user need to delete episode
    func deleteEpisode(episode: Episode) {
        
        let savedEpisodes = downloadEpisodes() // return downloadEpisodes from user defaults
        
         // means go for all item's in Episodes array and if  Episode (e) == episode paramter  remove it and return filteredEpisodes array
        let filteredEpisodes = savedEpisodes.filter { (e) -> Bool in
            // you should use episode.collectionId to be safer with deletes
            return e.title != episode.title
        }
        do{
            let data = try JSONEncoder().encode(filteredEpisodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
        }catch let encodeErr{
            print("Failed to encode episode:", encodeErr)
        }
    }
    
    // if user need to download new Episode
    func downloadEpisode(episode: Episode) {
        
        do{
            var episodes = downloadEpisodes() // return downloadEpisodes from user defaults
            episodes.insert(episode, at: 0)  //insert episode at the front of the list
            let data = try JSONEncoder().encode(episodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
        } catch let encoderError {
            print("Failed to encode episode ", encoderError)
        }
        
    }
    
    // return downloadEpisodes from user defaults
    func downloadEpisodes() -> [Episode] {
        
        guard let episodeData = data(forKey: UserDefaults.downloadedEpisodesKey) else { return [] }
        do{
            let episodes = try JSONDecoder().decode([Episode].self, from: episodeData)
            return episodes
        } catch let decoderError {
            print("Failed to decode episode ", decoderError)
        }
        return []
        
    }
    
    // fetch saved podcast's from user default
    func savedPodcasts() -> [Podcast] {
        
        /*unarchiveTopLevelObjectWithData() method of NSKeyedArchiver that's read data which saved in favoritedPodcastKey from userdefaults and turns this data object  into a podcast object and load it into savePodcasts array */
        guard let savedPodcastsData = UserDefaults.standard.data(forKey: UserDefaults.favoritedPodcastKey) else { return [] }
        
        guard let savePodcasts = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPodcastsData) as? [Podcast] else { return [] }
        
        return savePodcasts!
        
    }
    
    // delete selected podcast from saved podcast's and save filteredPodcasts again into user default
    func deletePodcast(podcast: Podcast) {
        
        let podcasts = savedPodcasts() // return save podcast's from user defualt
        
        // means go for all item's in podcasts array and if  podcast (p) == podcast paramter  remove it and return filteredPodcasts array
        let filteredPodcasts = podcasts.filter { (p) -> Bool in
            return p.trackName != podcast.trackName && p.artistName != podcast.artistName
        }
        
        /*archivedData() method of NSKeyedArchiver which turns an object of podcast into a Data object then write that to UserDefaults.
         podcast class  must conform to the NSCoding protocol */
        
        //converts our filteredPodcasts array into a data
        let data = try? NSKeyedArchiver.archivedData(withRootObject: filteredPodcasts, requiringSecureCoding: false)
        
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritedPodcastKey) //save that data object to UserDefaults
        
    }
    
}
