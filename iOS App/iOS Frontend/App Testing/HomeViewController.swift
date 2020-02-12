//
//  HomeViewController.swift
//  App Testing
//
//  Created by Okwuchukwu Godson Azie on 1/29/20.
//  Copyright © 2020 Okwuchukwu Godson Azie. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {
    

    //variable section
    var player: AVPlayer?
    
    //FOR TESTING PURPOSES ONLY!!!!
    var totalSpotsSR = 168
    var totalSpotsTest = 5
    var totalSpotsMSC = 200
    var availableSpots = 4
    var testSpots = 3
    var color = UIImage(named: "hollow")
    
    //outlet section
    @IBOutlet weak var backgroundOutlet: UIView!
    
    //more info outlets should be seperate to have funtionality for each individual lot
    @IBOutlet weak var moreInfoOutlet: UIView!
    @IBOutlet weak var moreInfoOutlet2: UIView!
    @IBOutlet weak var moreInfoOutlet3: UIView!
    
    //status outlets
    @IBOutlet weak var lotOneStatusOutlet: UIImageView!
    @IBOutlet weak var lotTwoStatusOutlet: UIImageView!
    @IBOutlet weak var lotThreeStatusOutlet: UIImageView!
    
    
    override func viewDidLoad() {
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
        
        //lot status outlet initialization
        if availableSpots == 0{    //lot full
            color = UIImage(named: "red")!
            lotOneStatusOutlet.image = color
            lotTwoStatusOutlet.image = color
            lotThreeStatusOutlet.image = color
        }
        else if (availableSpots >= 0 && availableSpots < 5){
            color = UIImage(named: "open")!
            lotOneStatusOutlet.image = color
            lotTwoStatusOutlet.image = color
            lotThreeStatusOutlet.image = color
        }
        else {//in case calculation of available spots goes wrong (for ex. returns a negative number)
            color = UIImage(named: "hollow")!
            lotOneStatusOutlet.image = color
            lotTwoStatusOutlet.image = color
            lotThreeStatusOutlet.image = color
        }
        
        //more info outlet initialization
        moreInfoOutlet.isHidden = true
        moreInfoOutlet2.isHidden = true
        moreInfoOutlet3.isHidden = true
            }
    
    @IBAction func logOutButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyBoard.instantiateViewController(withIdentifier: "loginView") as! ViewController
                self.present(loginViewController, animated: true, completion: nil)
        if #available(iOS 13.0, *) {
            loginViewController.isModalInPresentation = true // available in IOS13
        }
    }
    @IBAction func settingsButton(_ sender: Any) {
    }
    
    //lot detail buttons must be seperate to maintain functionality
    //tile 1
    @IBAction func lotDetailButton(_ sender: Any) {
        moreInfoOutlet.isHidden = false
    }
    @IBAction func closeMoreInfoButton(_ sender: Any) {
        moreInfoOutlet.isHidden = true
    }
    
    //tile 2
    @IBAction func lotDetailButton2(_ sender: Any) {
        moreInfoOutlet2.isHidden = false
    }
    @IBAction func closeMoreInfoButton2(_ sender: Any) {
        moreInfoOutlet2.isHidden = true
    }
    @IBAction func lotInfoButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let testViewController = storyBoard.instantiateViewController(withIdentifier: "testLotView") as! TestLotViewController
                self.present(testViewController, animated: true, completion: nil)
    }
    
    //tile 3
    @IBAction func lotDetailButton3(_ sender: Any) {
        moreInfoOutlet3.isHidden = false
    }
    @IBAction func closeMoreInfoButton3(_ sender: Any) {
        moreInfoOutlet3.isHidden = true
    }
    
}
