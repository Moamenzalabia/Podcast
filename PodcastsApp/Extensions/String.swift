//  String.swift
//  PodcastsApp
//  Created by MOAMEN on 9/12/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.


import Foundation

extension String {
    
    // to replace any http to https to avoid securaty excepation's
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self :
                 self.replacingOccurrences(of: "http", with: "https")
    
    }
}
