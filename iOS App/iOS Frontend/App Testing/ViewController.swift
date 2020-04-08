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
        let email = emailOutlet.text!
        let username = usernameOutlet.text!
        let password = passwordOutlet.text!
        let confPassword = confirmPasswordOutlet.text!
        //fields check
        if (email.count > 22 && email.count <= 35) && (email[email.index(email.endIndex, offsetBy: -18)..<email.endIndex] == "@student.pvamu.edu") && (username.count > 5 && username.count <= 20) && (password.count > 5 && username.count <= 20) && (confPassword == password) {
            //send
            sendData(name: username, pass: password, mail: email)
            displayAlert(msgTitle: "Registration processed", msgContent: "Check your email to complete registration")
            //clear all fields and display login page
            emailOutlet.text = ""
            usernameOutlet.text = ""
            passwordOutlet.text = ""
            confirmPasswordOutlet.text = ""
            registrationOutlet.isHidden = true
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

    //Http POST function
    @objc func sendData(name:String, pass:String, mail: String) {
        // Create a variable with required params being sent
        let params = ["email":"\(mail)", "password":"\(pass)", "username":"\(name)"]
         //print(params)
         guard let url = URL(string: "http://10.160.4.168:5000/api/users") else { return }

         var request = URLRequest(url: url)
         request.httpMethod = "POST"

         guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed) else { return }
         request.httpBody = httpBody
         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
         print("\n~~~~\(httpBody)\n~~~~~~\n")

         let session = URLSession.shared
         session.dataTask(with: request) { (data, response, error) in
             if let response = response {
                 print(response)
             }

             if let data = data {
                 do {
                     let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                     print(json)
                 } catch {
                     print(error)
                 }
             }
         }.resume()
    }
    
}


