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
    
    var tsVacant: [Bool] = []   //array that contains all the isVacant values from sensors
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    
                        do {
                            //jSon object for the parking lot.
                            let mscJson = try decoder.decode(lot.self, from: data!)
                            
                            for i in 0...mscJson.sensors.count-1 {
                                if mscJson.sensors[i].isVacant == true {
                                    //Network task executed in background
                                    //But UITextfield can only display string which is processed in main thread
                                    DispatchQueue.main.async {  //force network process into main thread
                                        //spot = UIImage(named: "car flipped")!
                                        //ts[i].image = spot
                                        print(mscJson.sensors[i]._id)
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
        
        
                //    tsVacant.append(true)
        //    tsVacant.append(true)
        //    tsVacant.append(true)
        //    tsVacant.append(false)
        //    tsVacant.append(true)
        //    tsVacant.append(true)
        //    tsVacant.append(false)
        //    tsVacant.append(true)
        //    tsVacant.append(false)
        //    for i in 0...34{
        //        if tsVacant[i] == true{
        //            spot = UIImage(named: "car flipped")!
        //            ts[i].image = spot
        //        }
        //    }
            
        
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

