//  UIApplication.swift
//  PodcastsApp
//  Created by MOAMEN on 12/12/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.


import UIKit

extension UIApplication {
    
    // public variable from MainTabBarController
    static func mainTabBarController () -> MainTabBarController? {
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
