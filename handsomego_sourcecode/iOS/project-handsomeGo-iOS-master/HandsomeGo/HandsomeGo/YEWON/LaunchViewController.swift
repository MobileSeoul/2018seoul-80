//
//  LaunchViewController.swift
//  HandsomeGo
//
//  Created by 조예원 on 29/09/2018.
//  Copyright © 2018 박세은. All rights reserved.
//

import UIKit
import SwiftGifOrigin

class LaunchViewController: UIViewController {
    @IBOutlet weak var launchImg: UIImageView!
    
    var timer = Timer()
    var timerIsOn = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        launchImg.loadGif(name: "handsomego_splash")
        
        if !timerIsOn {
            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self,      selector: #selector(timerRunning), userInfo: nil, repeats: false)
            timerIsOn = true
            let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.present(vc, animated: false, completion: nil)
        }
    }
    
    @objc func timerRunning() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    
}
