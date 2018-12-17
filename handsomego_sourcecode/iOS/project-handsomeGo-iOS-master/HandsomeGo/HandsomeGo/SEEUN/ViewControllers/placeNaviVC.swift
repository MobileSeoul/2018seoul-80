
//
//  placeNaviVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class placeNaviVC: UINavigationController {
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let vc = self.viewControllers[0] as! SimpleInfoVC
        
        vc.placeId = id
    }


}
