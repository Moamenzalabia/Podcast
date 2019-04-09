//  PlayerDetailsView+Gestures.swift
//  PodcastsApp
//  Created by MOAMEN on 12/12/1397 AP.
//  Copyright © 1397 MOAMEN. All rights reserved.

import UIKit

extension PlayerDetailsView{
    
    // to handle maximizedStackView or minimumize playerview
    @objc func handleTabPan(geture: UIPanGestureRecognizer) {
        
        if geture.state == .changed {
            handlePanChange(geture: geture)
        }else if geture.state == .ended {
            handlePanEnded(geture: geture)
        }
        
    }
    
    // to change alpha of maximizedStackView or minimumize playerview if you cilck on them
    func handlePanChange (geture: UIPanGestureRecognizer) {
        let translation = geture.translation(in: self.superview)
        self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        
        self.miniPlayerView.alpha = 1 + translation.y / 200
        self.maximizedStackView.alpha = -translation.y / 200
    }
    
    //  if you click on miniPlayerView once it call maximizePlayerDetails it at this time
    func handlePanEnded (geture: UIPanGestureRecognizer) {
        let translation = geture.translation(in: self.superview)
        let velocity = geture.velocity(in: self.superview)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
            
            if translation.y < -200 || velocity.y < -500 {
                UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: nil)
            }else{
                self.miniPlayerView.alpha = 1
                self.maximizedStackView.alpha = 0
            }
        })
    }
    
    @objc func handleTabMaximize() {
        UIApplication.mainTabBarController()?.maximizePlayerDetails(episode: nil)
    }
    
}
