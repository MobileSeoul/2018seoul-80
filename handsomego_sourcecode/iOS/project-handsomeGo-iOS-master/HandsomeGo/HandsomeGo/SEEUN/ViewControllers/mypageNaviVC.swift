
//
//  mypageNaviVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class mypageNaviVC: UINavigationController {
    var opened: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let open = self.opened {
            let vc = self.viewControllers[0] as! MyPageTabVC
            vc.opened = open
        }
    }

}
