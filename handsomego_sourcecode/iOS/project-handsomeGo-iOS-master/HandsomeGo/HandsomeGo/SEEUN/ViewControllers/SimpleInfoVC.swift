//
//  SimpleInfoVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 26..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class SimpleInfoVC: UIViewController {
    let token = UserDefaults.standard.string(forKey: "token")!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var placeTableView: UITableView!
    
    var placeId = 1
    var stampStatus = 0
    var place: Place? {
        didSet {
            placeTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataInit()
        placeTableView.delegate = self
        placeTableView.dataSource = self
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func dataInit() {
        PlaceService.shareInstance.getPlace(placeId: placeId, completion: { (place) in
            print("성공!!")
            self.place = place
            
        }) { (err) in
            let message = UIAlertController(title: "알림", message: "네트워크 연결상태를 확인하세요", preferredStyle: .alert)
            let ok = UIAlertAction(title:"확인", style: UIAlertActionStyle.default){
                (UIAlertAction) in
            }
            message.addAction(ok)
            self.present(message, animated: true, completion: nil)
        }
        
        StampStatusService.shareInstance.getStampStatus(token: token, stampId: placeId, completion: { (stamp) in
            if stamp.stampStatus == 1 {
                self.stampStatus = stamp.stampStatus
                self.saveButton.setTitle("적립내역 보기", for: .normal)
            }
        }) { (err) in
            let message = UIAlertController(title: "알림", message: "네트워크 연결상태를 확인하세요", preferredStyle: .alert)
            let ok = UIAlertAction(title:"확인", style: UIAlertActionStyle.default){
                (UIAlertAction) in
            }
            message.addAction(ok)
            self.present(message, animated: true, completion: nil)
        }
    }
    
    @IBAction func stampAction(_ sender: UIButton) {
        // 게스트일때
        if token == ""{
            
        } else { // 로그인했을때
            if stampStatus == 0{
                
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "saveStampVC") as! saveStampVC
                vc.placeId = self.placeId
                
                StampSaveService.shareInstance.saveStamp(token: UserDefaults.standard.string(forKey: "token")!, stampId: placeId, completion: { (res) in
                    print(res)
                    self.navigationController?.pushViewController(vc, animated: true)
                }) { (err) in
                    
                    let message = UIAlertController(title: "알림", message: "네트워크 연결상태를 확인하세요", preferredStyle: .alert)
                    let ok = UIAlertAction(title:"확인", style: UIAlertActionStyle.default){
                        (UIAlertAction) in
                    }
                    message.addAction(ok)
                    self.present(message, animated: true, completion: nil)
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            
            } else if stampStatus == 1 {
                
                //홈으로 이동
                let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                vc.selectedIndex = 2
                self.present(vc, animated: false, completion: nil)
                
            }
        }
    }
    
    @IBAction func dismissAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension SimpleInfoVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if place != nil { return 1 }
        else {return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = placeTableView.dequeueReusableCell(withIdentifier: "PlaceInfoCell") as! PlaceInfoCell
        if let place = place {
            cell.placeImageView.imageFromUrl(place.placePic, defaultImgPath: "")
            cell.nameLabel.text = place.placeName
            cell.addressLabel.text = place.placeAddress
            cell.infoLabel.text = place.placeContent
            cell.reviewCntLabel.text = "\(place.commentCount)"
            if place.placeCategory == "도시 건축"{
                cell.colorBar.image = #imageLiteral(resourceName: "infoGreenBar")
            } else if place.placeCategory == "역사 문화"{
                cell.colorBar.image = #imageLiteral(resourceName: "infoOrangeBar")
            }
        }
        return cell
    }
    
    
}
