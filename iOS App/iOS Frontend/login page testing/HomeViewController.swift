//
//  HomeViewController.swift
//  login page testing
//
//  Created by student on 10/29/19.
//  Copyright © 2019 student. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    
    var player1: AVPlayer?
    @IBOutlet weak var homeViewOutlet: UIView!
    
    @IBOutlet weak var roundedButton: UIButton!
    @IBOutlet weak var roundedButton1: UIButton!
    @IBOutlet weak var roundedButton2: UIButton!
    @IBOutlet weak var roundedButton3: UIButton!
    @IBOutlet weak var roundedButton4: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.roundedButton.layer.cornerRadius = 20
        self.roundedButton1.layer.cornerRadius = 20
        self.roundedButton2.layer.cornerRadius = 20
        self.roundedButton3.layer.cornerRadius = 20
        self.roundedButton4.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
        
        func playBackgroundVideo() {
            if let filePath = Bundle.main.path(forResource: "background", ofType: "mov") {
                let filePathUrl = NSURL.fileURL(withPath: filePath)
                player1 = AVPlayer(url: filePathUrl)
                let playerLayer = AVPlayerLayer(player: player1)
                playerLayer.frame = self.homeViewOutlet.bounds
                playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
                
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player1?.currentItem, queue: nil) {
                    (_) in self.player1?.seek(to: CMTime.zero)
                    self.player1?.play()
                }
                self.homeViewOutlet.layer.addSublayer(playerLayer)
                player1?.play()
            }
        }
        playBackgroundVideo()
    }
}
