//
//  MSCViewController.swift
//  App Testing
//
//  Created by Rene Brice Ouoba on 2/26/20.
//  Copyright © 2020 Okwuchukwu Godson Azie. All rights reserved.
//

import UIKit
import AVFoundation

class MSCViewController: UIViewController {
    
    var player: AVPlayer?
    @IBOutlet weak var backgroundOutlet: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Background video
        func playBackgroundVideo() {
            if let filePath = Bundle.main.path(forResource: "Background", ofType:"mov") {
                let filePathUrl = NSURL.fileURL(withPath: filePath)
                player = AVPlayer(url: filePathUrl)
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = self.backgroundOutlet.bounds
                playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: nil) { (_) in
                    self.player?.seek(to: CMTime.zero)
                    self.player?.play()
                }
                self.backgroundOutlet.layer.addSublayer(playerLayer)
                player?.play()
            }
        }
        playBackgroundVideo()
    }
    
    
    }
