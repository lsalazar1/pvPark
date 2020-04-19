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
    //let homeViewController = HomeViewController() //Godson's auto log in code
    
    
    //Outlet Section:
    //Outlet for the video background
    @IBOutlet var backgroundOutlet: UIView!
    
    //Outlet for the registration view
    @IBOutlet weak var registrationOutlet: UIVisualEffectView!
    
    //Outlets for text fields in the log in view
    @IBOutlet weak var usernameOutletLogin: UITextField!
    @IBOutlet weak var passwordOutletLogin: UITextField!
    
    
    //Outlets for text fields in the registration view
    @IBOutlet weak var fullNameOutlet: UITextField!
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
                        player!.preventsDisplaySleepDuringVideoPlayback = false  //keeps video from deactivating screen auto lock
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
        let user = usernameOutletLogin.text!
        let pass = passwordOutletLogin.text!
                
        let loginParams = ["username":"\(user)", "password":"\(pass)"]
                
        //Uncomment to use with local machine server
        //guard let url = URL(string: "http://192.168.3.100:5000/api/auth") else { return }
                
        //Comment to use local server
        guard let url = URL(string: "https://blooming-mountain-10766.herokuapp.com/api/auth") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        guard let httpBody = try? JSONSerialization.data(withJSONObject: loginParams, options: .fragmentsAllowed) else { return }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //print("\n~~~~\(httpBody)\n~~~~~~\n")

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                print(response)
//            }
                        
            let myResponse = response as! HTTPURLResponse
            if myResponse.statusCode == 400 {
                DispatchQueue.main.async {
                    self.displayAlert(msgTitle: "Error", msgContent: "User not found or wrong password")
                }
            } else {
                DispatchQueue.main.async {
                    self.usernameOutlet.text = ""
                    self.passwordOutlet.text = ""
                    //self.displayAlert(msgTitle: "Welcome " + user, msgContent: "")
                                
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let homeView = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
                            self.present(homeView, animated: true, completion: nil)
                }
            }
                        
        //                 if let data = data {
        //                     do {
        //                         let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        //                         print(json)
        //
        //                     } catch {
        //                         print(error)
        //                     }
        //                 }
        }.resume()
        
        
        //Godson's auto log in code
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let homeViewController = storyBoard.instantiateViewController(withIdentifier: "homeViewController") as! HomeViewController
//                self.present(homeViewController, animated: true, completion: nil)
//            if #available(iOS 13.0, *) {
//                homeViewController.isModalInPresentation = true // available in IOS13
//            }
    }
    
    //Action for the home page register button
    @IBAction func registerButton(_ sender: Any) {
        registrationOutlet.isHidden = false
    }
    
    //Action for submit button on the registration page
    @IBAction func registerSubmitButton(_ sender: Any) {
        let fullName = fullNameOutlet.text!
        let email = emailOutlet.text!
        let username = usernameOutlet.text!
        let password = passwordOutlet.text!
        let confPassword = confirmPasswordOutlet.text!
        //fields check
        if (fullName.count > 0 && fullName.count <= 20) && (email.count > 15 && email.count <= 35) && (email[email.index(email.endIndex, offsetBy: -9)..<email.endIndex] == "pvamu.edu") && (username.count >= 4 && username.count <= 15) && (password.count >= 8) && (confPassword == password) {
            //send
            sendData(fullName: fullName, mail: email, pass: password, username: username)
            displayAlert(msgTitle: "Registration processed", msgContent: "Check your email to complete registration")
            //clear all fields and display login page
            fullNameOutlet.text = ""
            emailOutlet.text = ""
            usernameOutlet.text = ""
            passwordOutlet.text = ""
            confirmPasswordOutlet.text = ""
            registrationOutlet.isHidden = true
        }
        else {
            displayAlert(msgTitle: "Wrong input", msgContent: "Please ensure that all fields are properly filled (must use your PV email)")
        }
    }
    
    //Action for the regristration page cancel button
    @IBAction func registerCancelButton(_ sender: Any) {
        fullNameOutlet.text = ""
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
    @objc func sendData(fullName:String, mail:String, pass:String, username:String) {
        // Create a variable with required params being sent
        let params = ["name":"\(fullName)", "email":"\(mail)", "password":"\(pass)", "username":"\(username)"]
         //print(params)
         guard let url = URL(string: "https://blooming-mountain-10766.herokuapp.com/api/users") else { return }
//        //test with local machine
//        guard let url = URL(string: "http://192.168.3.100:5000/api/users") else { return }

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


