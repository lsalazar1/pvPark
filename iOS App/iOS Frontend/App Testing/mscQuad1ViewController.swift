//
//  mscQuad1ViewController.swift
//  App Testing
//
//  Created by Rene Ouoba on 2/26/20.
//  Copyright © 2020 Okwuchukwu Godson Azie. All rights reserved.
//

import UIKit
import AVFoundation

class mscQuad1ViewController: UIViewController {

    var player: AVPlayer?
    @IBOutlet weak var backgroundOutlet: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
       
    //read jSon from MSC view controller and display state of quad1
//    tsVacant.append(true)
//    tsVacant.append(true)
//    tsVacant.append(true)
//    tsVacant.append(false)
//    tsVacant.append(true)
//    tsVacant.append(true)
//    tsVacant.append(false)
//    tsVacant.append(true)
//    tsVacant.append(false)
//    for i in 0...8{
//        if tsVacant[i] == false{
//            color = UIImage(named: "red_circle")!
//            ts[i].image = color
//        }
//        else if (tsVacant[i] == true){
//            color = UIImage(named: "green_circle")!
//            ts[i].image = color
//        }
//        else{    //in case sensor is not working
//
//        }
//    }
    
    }

