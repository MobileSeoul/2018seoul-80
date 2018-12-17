//
//  TabBarVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 24..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {

    let token = UserDefaults.standard.string(forKey: "token")!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController is QRcodeTabVC {
            //
            if token == ""{
                let message = UIAlertController(title: "로그인이 필요", message: "로그인 하시겠습니까?", preferredStyle: .alert)
                let cancel = UIAlertAction(title:"취소", style: UIAlertActionStyle.default){
                    (UIAlertAction) in
                    //
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                    
                    self.present(vc, animated: false, completion: nil)
                }
                let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default){
                    (UIAlertAction) in
                    UserDefaults.standard.removeObject(forKey: "token")
                    let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                    self.present(vc, animated: true,completion: nil)
                }
                message.addAction(cancel)
                message.addAction(action)
                self.present(message, animated: true, completion: nil)
            }
            
            //
            else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let controller = storyboard.instantiateViewController(withIdentifier: "QRcodeTabVC") as? QRcodeTabVC {
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: true, completion: nil)
            }
            
            return false
            }
        }
        
        // Tells the tab bar to select other view controller as normal
        return true
    }
    
}

