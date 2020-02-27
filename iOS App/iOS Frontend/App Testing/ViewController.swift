//
//  ViewController.swift
//  App Testing
//
//  Created by Okwuchukwu Godson Azie on 1/28/20.
//  Copyright © 2020 Okwuchukwu Godson Azie. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //Variable Decleration Section:
    var player: AVPlayer?
    let homeViewController = HomeViewController()
    
    
    //Outlet Section:
    //Outlet for the video background
    @IBOutlet var backgroundOutlet: UIView!
    
    //Outlet for the registration view
    @IBOutlet weak var registrationOutlet: UIVisualEffectView!
    
    //Outlets for text fields in the registration view
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var confirmPasswordOutlet: UITextField!
    
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
        registrationOutlet.isHidden = true
            }
    
    //Actions Section:
    //Action for forgot username/password
    @IBAction func forgotButton(_ sender: Any) {
    }
    //Action for the home page login button
    @IBAction func loginButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
                self.present(homeViewController, animated: true, completion: nil)
            if #available(iOS 13.0, *) {
                homeViewController.isModalInPresentation = true // available in IOS13
            }
    }
    //Action for the home page register button
    @IBAction func registerButton(_ sender: Any) {
        registrationOutlet.isHidden = false
    }
    //Action for the registration page submit button
    @IBAction func registerSubmitButton(_ sender: Any) {
        registrationOutlet.isHidden = true
    }
    //Action for the regristration page cancel button
    @IBAction func registerCancelButton(_ sender: Any) {
        registrationOutlet.isHidden = true
    }
}


