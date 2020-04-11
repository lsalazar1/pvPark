//
//  TestLotViewController.swift
//  App Testing
//
//  Created by Okwuchukwu Godson Azie on 2/5/20.
//  Copyright © 2020 Okwuchukwu Godson Azie. All rights reserved.
//

import UIKit
import AVFoundation

class TestLotViewController: UIViewController {

    
    var player: AVPlayer?
    @IBOutlet weak var backgroundOutlet: UIView!
    
    //outlets for parking spots
    @IBOutlet var spaceOutlet: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        func playBackgroundVideo() {
            if let filePath = Bundle.main.path(forResource: "Background", ofType:"mov") {
                let filePathUrl = NSURL.fileURL(withPath: filePath)
                player = AVPlayer(url: filePathUrl)
                player!.preventsDisplaySleepDuringVideoPlayback = false  //keeps video from deactivating screen auto lock
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
