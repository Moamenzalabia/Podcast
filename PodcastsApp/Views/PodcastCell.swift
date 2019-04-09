//  PodcastCell.swift
//  PodcastsApp
//  Created by MOAMEN on 9/8/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.

import UIKit
import SDWebImage

class PodcastCell: UITableViewCell {

    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    var podcast: Podcast! {
        
        didSet{
        trackNameLabel.text = podcast.trackName
        artistNameLabel.text = podcast.artistName
        episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
        guard let  stringUrl = podcast.artworkUrl60 else{ return }
        downloadImages(stringUrl: stringUrl)
      }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // download podcastImage
    fileprivate func downloadImages(stringUrl: String) {
        guard let url = URL(string: stringUrl) else { return }
        /*
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data  = data else { return }
            DispatchQueue.main.async {
                self.podcastImageView.image =  UIImage(data: data)
            }
            
        }.resume()
        */
        podcastImageView.sd_setImage(with: url, completed: nil) 
    }

}
