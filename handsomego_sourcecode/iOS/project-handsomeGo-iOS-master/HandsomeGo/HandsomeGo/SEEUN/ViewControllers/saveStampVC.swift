//
//  saveStampVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class saveStampVC: UIViewController {
    var placeId = 0
    let token = UserDefaults.standard.string(forKey: "token")!
    
    @IBOutlet weak var squareView: UIView!
    @IBOutlet weak var stampImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNaviBar()
        dataInit()
    }
    
    @IBAction func saveAction(_ sender: UIButton) {
        
        //마이페이지로 화면전환
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        vc.selectedIndex = 2
        
        self.present(vc, animated: false, completion: nil)
    }
    
    func dataInit() {
        StampStatusService.shareInstance.getStampStatus(token: token, stampId: placeId, completion: { (stamp) in
            self.title = stamp.placeName
            self.stampImageView.imageFromUrl(stamp.stampPic, defaultImgPath: "")
            self.categoryLabel.text = stamp.placeCategory
            self.rankLabel.text = "\(stamp.rank)위"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
            dateFormatter.timeZone = TimeZone.current
            let originDate = dateFormatter.date(from: stamp.stampDate)
            dateFormatter.dateFormat = "yyyy.MM.dd"
            self.dateLabel.text = dateFormatter.string(from: originDate!)
            
        }) { (err) in
            
            let message = UIAlertController(title: "알림", message: "네트워크 연결상태를 확인하세요", preferredStyle: .alert)
            let ok = UIAlertAction(title:"확인", style: UIAlertActionStyle.default){
                (UIAlertAction) in
            }
            message.addAction(ok)
            self.present(message, animated: true, completion: nil)
        }
    }
    
    func setupNaviBar() { self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFB", size: 17)!, NSAttributedStringKey.foregroundColor: UIColor.black]
    }
    
    func setupView() {
        squareView.layer.shadowRadius = 6
        squareView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        squareView.layer.shadowOffset = CGSize(width: 0, height: 3)
        squareView.layer.shadowOpacity = 0.3
        
    }
    
}
