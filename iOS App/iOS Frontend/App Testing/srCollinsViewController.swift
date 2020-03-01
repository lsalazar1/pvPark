//
//  srCollinsViewController.swift
//  App Testing
//
//  Created by Rene Ouoba on 2/28/20.
//  Copyright © 2020 Okwuchukwu Godson Azie. All rights reserved.
//

import UIKit
import AVFoundation

class srCollinsViewController: UIViewController {
    
    var player: AVPlayer?
    @IBOutlet weak var backgroundOutlet: UIView!
    
    @IBOutlet var src: [UIImageView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pointer to home page
//        let homePage = self.tabBarController?.viewControllers?[1] as! HomeViewController
//        var car = UIImage(named: "car straight")!
//        print(homePage.src.availableSpots)
//        for i in 0...homePage.src.sensors.count-1 {
//            if homePage.src.sensors[i].isVacant == false {
//                src[i].image = car
//            }
//        }
        
//        let urlStringSRC = "https://blooming-mountain-10766.herokuapp.com/api/srcollins"
//                        let urlSRC = URL(string: urlStringSRC)
//                               guard urlSRC != nil else {
//                                   return
//                               }
//                        let sessionSRC = URLSession.shared
//                        let dataTaskSRC = sessionSRC.dataTask(with: urlSRC!) { (data, response, error) in
//                            //Check for error
//                            if error == nil && data != nil {
//                                //Parse json
//                                let decoder = JSONDecoder()
//
//                                do {
//                                    //jSon object for the parking lot.
//                                    let srcJson = try decoder.decode(lot.self, from: data!)
//
//                                    var car = UIImage(named: "car straight")!
//                                    for i in 0...srcJson.sensors.count-1 {
//                                        if srcJson.sensors[i].isVacant == false {
//                                            //Network task executed in background
//                                            //But UITextfield can only display string which is processed in main thread
//                                            DispatchQueue.main.async {  //force network process into main thread
//                                                self.src[i].image = car
//                                            }
//                                         }
//                                    }
//                                }
//                                catch {
//                                    print("Parsing error")
//                                }
//                            }
//                        }
//                        //Make the API call
//                        dataTaskSRC.resume()
        
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
