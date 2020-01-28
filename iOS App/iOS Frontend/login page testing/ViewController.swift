//
//  ViewController.swift
//  login page testing
//
//  Created by student on 10/24/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    var player: AVPlayer?
    
    @IBOutlet weak var videoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        func playBackgroundVideo() {
            if let filePath = Bundle.main.path(forResource: "background", ofType:"mov") {
                let filePathUrl = NSURL.fileURL(withPath: filePath)
                player = AVPlayer(url: filePathUrl)
                let playerLayer = AVPlayerLayer(player: player)
                playerLayer.frame = self.videoView.bounds
                playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: nil) { (_) in
                    self.player?.seek(to: CMTime.zero)
                    self.player?.play()
                }
                self.videoView.layer.addSublayer(playerLayer)
                player?.play()
            }
        }
        playBackgroundVideo()
    }

}

