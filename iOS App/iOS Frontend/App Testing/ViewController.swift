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
        //Play background video
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
        //Hide keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
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
    //Action for submit button on the registration page
    @IBAction func registerSubmitButton(_ sender: Any) {
        var email = emailOutlet.text!
        var username = usernameOutlet.text!
        var password = passwordOutlet.text!
        var confPassword = confirmPasswordOutlet.text!
        //email field check
        if (email.count > 22 && email.count <= 35) && (email[email.index(email.endIndex, offsetBy: -18)..<email.endIndex] == "@student.pvamu.edu") && (username.count > 5 && username.count <= 20) && (password.count > 5 && username.count <= 20) && (confPassword == password) {
            print("Good job")
        }
        else {
            displayAlert(msgTitle: "Error", msgContent: "Wrong input. Please ensure that you are using a PV student e-mail or all fields are properly filled.")
        }
        

        
    }
    //Action for the regristration page cancel button
    @IBAction func registerCancelButton(_ sender: Any) {
        emailOutlet.text = ""
        usernameOutlet.text = ""
        passwordOutlet.text = ""
        confirmPasswordOutlet.text = ""
        registrationOutlet.isHidden = true
    }
    //Display alert message when there is a incorrect entry
    func displayAlert(msgTitle:String, msgContent:String){
        let alertController = UIAlertController(title: msgTitle, message: msgContent, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }

    
}


