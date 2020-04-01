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
    
    @IBOutlet var qd1: [UIImageView]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadQuad1()
        
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
       
    
    //function that processes the http get
    @objc func loadQuad1() {
        let urlStringMSC = "https://blooming-mountain-10766.herokuapp.com/api/msc"
        let urlMSC = URL(string: urlStringMSC)
            guard urlMSC != nil else {
                return
            }
        let sessionMSC = URLSession.shared
        let dataTaskMSC = sessionMSC.dataTask(with: urlMSC!) { (data, response, error) in
            //Check for error
            if error == nil && data != nil {
                //Parse json
                let decoder = JSONDecoder()
                            
                do {//jSon object for the parking lot.
                    let mscJson = try decoder.decode(lot.self, from: data!)
        
                    let car = UIImage(named: "car straight")!
                    for i in 0...34 {
                        if mscJson.sensors[i].isVacant == false {
                            //Network task executed in background
                            //But UITextfield can only display string which is processed in main thread
                            DispatchQueue.main.async {  //force network process into main thread
                                self.qd1[i].image = car
                            }
                        }
                    }
                }
                catch {
                    print("Parsing error")
                }
            }
        }
        //Make the API call
        dataTaskMSC.resume()
    }
}

