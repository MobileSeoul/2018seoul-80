//
//  HomeTabVC.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 10..
//  Copyright © 2018년 박세은. All rights reserved.
//

import UIKit

class HomeTabVC: UIViewController {
    var check = false
    
    var rankingList: [RankPlace] = [] {
        didSet {
            rankTableView.reloadData()
        }
    }
    
    var choosedPlace: Place!
    var detailOpened = false {
        didSet {
            mapDetailView.isHidden = !detailOpened
        }
    }
    
    @IBOutlet weak var mapBtn: UIButton!
    @IBOutlet weak var rankBtn: UIButton!
    @IBOutlet weak var mapUnderBar: UIView!
    @IBOutlet weak var rankUnderBar: UIView!
   
    // Map Outlet
    @IBOutlet weak var mapScrollView: UIScrollView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var mapImageView: UIImageView!
    
    // Map Detail Outlet
    @IBOutlet weak var mapDetailView: UIView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var detailBtn: UIButton!
    @IBOutlet var starCollection: [UIImageView]!
    
    // Rank Outlet
    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var rankTableView: UITableView!
    
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataInit()
        mapSetup()
        mapDetailSetup()
        rankSetup()
        setupNaviBar()
        //
        
    }
    
    func dataInit() {
        RankListService.shareInstance.getRankList(completion: { (res) in
            self.rankingList = res
           
        }) { (err) in
            let message = UIAlertController(title: "알림", message: "네트워크 연결상태를 확인하세요", preferredStyle: .alert)
            let ok = UIAlertAction(title:"확인", style: UIAlertActionStyle.default){
                (UIAlertAction) in
            }
            message.addAction(ok)
            self.present(message, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if check == false {
            let unit = self.view.frame.width/320
            mapScrollView.zoomScale = 1.45/unit
            mapScrollView.contentOffset = CGPoint(x: 160*unit, y: 35*unit)
        }
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        check = true
    }
    
    func setupNaviBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFB", size: 17)!, NSAttributedStringKey.foregroundColor: UIColor.black]
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
    }
    
    func rankSetup() {
        rankTableView.delegate = self
        rankTableView.dataSource = self
        
        rankUnderBar.isHidden = true
        rankView.isHidden = true
    }
    @IBAction func placeBtnAct(_ sender: UIButton) {
        let naviVc = UIStoryboard(name: "Place", bundle:nil ).instantiateViewController(withIdentifier: "PlaceNC") as! PlaceNC
        let vc = naviVc.viewControllers.first as! PlaceVC
        vc.tempPlace = self.choosedPlace
        self.present(naviVc, animated: true, completion: nil)
    }

    @IBAction func mapTapAction(_ sender: UIButton) {
        
        rankUnderBar.isHidden = true
        rankView.isHidden = true
        
        mapUnderBar.isHidden = false
        mapScrollView.isHidden = false
        
        mapDetailView.isHidden = !detailOpened
       
    }
    
    @IBAction func rankTapAction(_ sender: UIButton) {
        rankUnderBar.isHidden = false
        rankView.isHidden = false
        
        mapDetailView.isHidden = true
        mapUnderBar.isHidden = true
        mapScrollView.isHidden = true
    }
    
    @IBAction func mapIconTapAction(_ sender: UIButton) {
           self.detailOpened = true
        
        detailImageView.image = sender.currentImage
        
        PlaceService.shareInstance.getPlace(placeId: sender.tag, completion: { (place) in
            self.choosedPlace = place
            self.nameLabel.text = place.placeName
            self.addressLabel.text = place.placeAddress
            for i in 0...4 {
                if i < place.placeStar {
                    self.starCollection[i].image = UIImage(named: "starYellow.png")
                } else {
                    self.starCollection[i].image = UIImage(named: "starBlank.png")
                }
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
    
    @objc func dismissView() {
        detailOpened = false
    }
    
    
}


extension HomeTabVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.mapView
    }
    func mapSetup() {
        mapDetailView.isHidden = true
        
        let detailViewDismiss = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        self.mapScrollView.addGestureRecognizer(detailViewDismiss)
        mapScrollView.delegate = self
        mapScrollView.alwaysBounceVertical = false
        mapScrollView.alwaysBounceHorizontal = false
        mapScrollView.minimumZoomScale = 1.0
        mapScrollView.maximumZoomScale = 3.0
        mapScrollView.contentOffset = CGPoint(x: 74, y: 0)
    }
    
    func mapDetailSetup(){
        mapDetailView.layer.shadowRadius = 6
        mapDetailView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        mapDetailView.layer.shadowOffset = CGSize(width: 0, height: 3)
        mapDetailView.layer.shadowOpacity = 0.15
        
        detailBtn.layer.cornerRadius = 25.5/2*self.view.frame.width/375

    }
        

}

//var place : RankPlace!

extension HomeTabVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let place = rankingList[indexPath.row]
        
        var cell: RankCell!
        
        if indexPath.row == 0 {
            cell = rankTableView.dequeueReusableCell(withIdentifier: "1stCell", for: indexPath) as! RankCell
            
        } else if indexPath.row == 1 {
            cell = rankTableView.dequeueReusableCell(withIdentifier: "2ndCell", for: indexPath) as! RankCell
        } else if indexPath.row == 2 {
            cell = rankTableView.dequeueReusableCell(withIdentifier: "3rdCell", for: indexPath) as! RankCell
        } else {
            cell = rankTableView.dequeueReusableCell(withIdentifier: "RankCell", for: indexPath) as! RankCell
            
        }
        
        cell.numLabel.text = "\(indexPath.row+1)"
        cell.nameLabel.text = place.placeName
        
        if place.placeCategory == "도시 건축"{
            cell.colorView.backgroundColor = #colorLiteral(red: 0.3294117647, green: 0.6078431373, blue: 0.05490196078, alpha: 1)
        } else if place.placeCategory == "과학 경제"{
            cell.colorView.backgroundColor = #colorLiteral(red: 0.3568627451, green: 0.6352941176, blue: 0.9647058824, alpha: 1)
        } else if place.placeCategory == "역사 문화"{
            cell.colorView.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.5450980392, blue: 0.1254901961, alpha: 1)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // next view
        PlaceService.shareInstance.getPlace(placeId: rankingList[indexPath.row].placeID, completion: { (place) in
            self.choosedPlace = place
            
            let naviVc = UIStoryboard(name: "Place", bundle:nil ).instantiateViewController(withIdentifier: "PlaceNC") as! PlaceNC
            let vc = naviVc.viewControllers.first as! PlaceVC
            vc.tempPlace = self.choosedPlace
            self.present(naviVc, animated: true, completion: nil)
        }) { (err) in
            let message = UIAlertController(title: "알림", message: "네트워크 연결상태를 확인하세요", preferredStyle: .alert)
            let ok = UIAlertAction(title:"확인", style: UIAlertActionStyle.default){
                (UIAlertAction) in
            }
            message.addAction(ok)
            self.present(message, animated: true, completion: nil)
        }
    }
    
}
