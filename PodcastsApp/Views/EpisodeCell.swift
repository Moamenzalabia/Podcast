//  EpisodeCell.swift
//  PodcastsApp
//  Created by MOAMEN on 9/12/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.

import UIKit

class EpisodeCell: UITableViewCell {

    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var episode: Episode! {
        
        didSet{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            pubDateLabel.text = dateFormatter.string(from: episode.pubDate!)
            titleLabel.text = episode.title!
            descriptionLabel.text = episode.description!
            guard let url = URL(string: episode.imageUrl?.toSecureHTTPS() ?? "") else { return }
            episodeImageView.sd_setImage(with: url)
            
         }
   
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
}
