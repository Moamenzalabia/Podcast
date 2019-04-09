//  CMTime.swift
//  PodcastsApp
//  Created by MOAMEN on 11/2/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.

import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        if CMTimeGetSeconds(self).isNaN { // self means actioal time object , nan -> not a number  this if no seconds number returened reurn --:-- string
            return "--:--"
        }
        // CMTimeMakeWithSeconds function (part of the Core Media framework in iOS
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds) // every %02d to represent two digit integer number so %02d:%02d means minute and secnds
        
        return timeFormatString
    }
}
