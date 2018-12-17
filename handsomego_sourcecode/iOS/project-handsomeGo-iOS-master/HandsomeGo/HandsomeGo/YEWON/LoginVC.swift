//
//  LoginVC.swift
//  HandsomeGo
//
//  Created by 조예원 on 27/09/2018.
//  Copyright © 2018 박세은. All rights reserved.
//
import UIKit
import KakaoCommon
import KakaoOpenSDK

class LoginVC: UIViewController {
    let userdefault = UserDefaults.standard
    
    @IBOutlet weak var logoImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImg.layer.masksToBounds = true
        self.logoImg.layer.cornerRadius = 60*self.view.frame.width/375
    }
    
    // kakao login
    @IBAction func kakaoBtnAct(_ sender: UIButton) {
        let session: KOSession = KOSession.shared()
        if session.isOpen() {
            session.close()
        }
        session.open(completionHandler: { (error) -> Void in
            if session.isOpen() {
                KOSessionTask.userMeTask {  (error, me) in
                    if let error = error as NSError? {
                        print(error)
                    } else if let me = me as KOUserMe? {
                        LoginService.logInit(id: me.id!, name: me.nickname!, profileImagePath: me.profileImageURL?.absoluteString ?? ""){ (token) in
                            self.userdefault.set(token, forKey: "token")
                            // next view
                            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                            self.present(vc, animated: false, completion: nil)
                         }
                    }
                }
            }
        })
    }

    @IBAction func guestBtnAct(_ sender: UIButton) {
        self.userdefault.set("", forKey: "token")
        // next view
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        self.present(vc, animated: false, completion: nil)
    }
}
