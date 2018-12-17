//
//  PlaceVC.swift
//  HandsomeGo
//
//  Created by 조예원 on 27/09/2018.
//  Copyright © 2018 박세은. All rights reserved.
//

import UIKit
import Kingfisher

class PlaceVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate{

    var tempPlace: Place!
    var tempToken =  UserDefaults.standard.string(forKey: "token")
    
    @IBOutlet weak var categoryColor: UIView!
    @IBOutlet weak var placeImgView: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAdd: UILabel!
    @IBOutlet weak var placeCategory: UILabel!
    @IBOutlet weak var placeContent: UILabel!
    @IBOutlet weak var placeScore: UILabel!
    @IBOutlet weak var placeReviewCount: UILabel!
    @IBOutlet var starImg: [UIImageView]!
    @IBOutlet weak var reviewCollection: UICollectionView!
    
    @IBOutlet weak var reviewCollectionH: NSLayoutConstraint!
    
    @IBOutlet weak var moreBtnH: NSLayoutConstraint!
    @IBOutlet weak var moreBtnView: UIView!
    
    @IBOutlet weak var reviewGoStarView: UIView!
    @IBOutlet weak var reviewStempLabel: UILabel!
    @IBOutlet weak var loginGoBtn: UIButton!
    @IBOutlet weak var reviewGoLabel: UILabel!
    @IBOutlet weak var reviewGoBtn: UIButton!
    @IBOutlet weak var reviewGoBtnH: NSLayoutConstraint!
    @IBOutlet weak var reviewGoBtnView: UIView!
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        funcForView()
        funcForDataUpload()
        mainScrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        funcForView()
        funcForDataUpload()
    }
    
    //
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == mainScrollView){
            
            var offset = scrollView.contentOffset.y / 150
            if offset > 1{
                offset = 1
                let color = UIColor(red:1, green:1, blue:1, alpha: offset)
                self.navigationController?.navigationBar.tintColor = UIColor.black
                self.navigationController?.navigationBar.backgroundColor = color
                UIApplication.shared.statusBarView?.backgroundColor = color
                
            }else{
                
                let color = UIColor(red:1, green:1, blue:1, alpha: offset)
                
                self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 100  , green: 100, blue: 100, alpha: 1)
                    
                self.navigationController?.navigationBar.backgroundColor = color
             
                UIApplication.shared.statusBarView?.backgroundColor = color
            }
            
        }
    }
    //
    func funcForView(){
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = .white
        
        //
        let leftButtonItem = UIBarButtonItem(image: UIImage(named: "dismissBtn"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(popAction))
        self.navigationItem.leftBarButtonItem = leftButtonItem
        
        
        
        //
        let Category = tempPlace?.placeCategory
        if ( Category == "역사 문화"){
            self.categoryColor.backgroundColor = UIColor(red: 251.0/255.0, green: 139.0/255.0, blue: 32.0/255.0, alpha: 1.0)
        }else if ( Category == "과학 경제"){
            self.categoryColor.backgroundColor = UIColor(red: 91.0/255.0, green: 162.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        }
        
        self.moreBtnView.isHidden = true
        self.moreBtnH.constant = 0
        
    }
    
    @objc func popAction(){
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //data upload
    var tempReviewList : [ReviewList] = [ReviewList]()
    func funcForDataUpload(){
        self.placeImgView.kf.setImage(with: URL(string: (tempPlace?.placePic)!))
        self.placeName.text = tempPlace?.placeName
        self.placeAdd.text = tempPlace?.placeAddress
        self.placeCategory.text = tempPlace?.placeCategory
        self.placeContent.text = tempPlace?.placeContent
        self.placeScore.text = String((tempPlace?.placeStar)!)
        for i in 0...4{
            if i < (tempPlace?.placeStar)! {
                self.starImg[i].image =  UIImage(named: "starYellow.png")
            }else{
                self.starImg[i].image = UIImage(named: "starBlank.png")
            }
        }
        
        ReviewService.getReivew(id: (tempPlace?.placeID)!){ (reviewList,message, status,myComment) in
            self.tempReviewList = reviewList
            let count = reviewList.count
            self.placeReviewCount.text = "리뷰 " + String(count) + "개"
            if (count > 1){
                self.moreBtnH.constant = 39
                self.moreBtnView.isHidden = false
            }else if (count == 0){
                self.reviewCollectionH.constant = 0
            }
            
            if myComment != nil{ // 이미 평가함. 뷰 없앰
                print("my comment nil")
                self.reviewGoBtnH.constant = 0
                self.reviewGoBtnView.isHidden = true
                // 리뷰 처리
            }else{
                self.reviewGoBtnH.constant = 95
                self.reviewGoBtnView.isHidden = false
                
                self.reviewGoBtnView.center.x = self.view.frame.width + 30
                
                UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 30.0, initialSpringVelocity: 30.0, options: UIViewAnimationOptions.curveEaseOut, animations: ({
                    self.reviewGoBtnView.center.x = self.view.frame.width / 2
                }), completion: nil)
                
                
                self.loginGoBtn.isHidden = true
                self.reviewGoBtn.isEnabled = false
                self.reviewGoBtn.isHidden = true
                self.reviewStempLabel.isHidden = true
                self.reviewGoStarView.isHidden = true
                
                if message == "로그인 해주세요."{ // 로그인 안함
                    self.loginGoBtn.isHidden = false
                    self.reviewGoLabel.text = "로그인 후 이용가능합니다"
                }else{
                    print(status)
                    if status == "스탬프를 먼저 찍어주세요"{
                        self.reviewGoLabel.text =  status
                        self.reviewStempLabel.isHidden = false
                    }else{ // 평가해주세요
                        self.reviewGoLabel.text = message
                        self.reviewGoBtn.isEnabled = true
                        self.reviewGoBtn.isHidden = false
                        self.reviewGoStarView.isHidden = false
                    }
                }
            }
            self.reviewCollection.reloadData()
        }
    }
    
    // 초기화
    @IBAction func loginGoBtnAct(_ sender: UIButton) {
           let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
          let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
           self.present(vc, animated: true,completion: nil)
        
    }
    
    // collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tempReviewList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCVC", for: indexPath) as! ReviewCVC

        cell.reviewName.text = self.tempReviewList[indexPath.row].writer_name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.sssZ"
        dateFormatter.timeZone = TimeZone.current
        let originDate = dateFormatter.date(from: self.tempReviewList[indexPath.row].comment_date)
        dateFormatter.dateFormat = "yyyy.MM.dd"
        cell.reviewDate.text = dateFormatter.string(from: originDate!)
        
        cell.reviewComment.text = self.tempReviewList[indexPath.row].comment_comment!
        for i in 0...4{
            if i < (self.tempReviewList[indexPath.row].comment_star) {
                cell.starImg[i].image = UIImage(named: "starYellow.png")
            }else{
                cell.starImg[i].image = UIImage(named: "starBlank.png")
            }
        }
        
        
         cell.photoImg[0].imageFromUrl(self.tempReviewList[indexPath.row].comment_pic1, defaultImgPath: "")
        cell.photoImg[1].imageFromUrl(self.tempReviewList[indexPath.row].comment_pic2, defaultImgPath: "")
        cell.photoImg[2].imageFromUrl(self.tempReviewList[indexPath.row].comment_pic3, defaultImgPath: "")
        cell.photoImg[3].imageFromUrl(self.tempReviewList[indexPath.row].comment_pic4, defaultImgPath: "")
        return cell
    }
    
    @IBAction func backBtnAct(_ sender: UIButton) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    
    // register btn act
    @IBAction func reviewBtnAct(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Place", bundle:nil ).instantiateViewController(withIdentifier: "ReviewVC") as! ReviewVC
        vc.tempPlaceId = (self.tempPlace?.placeID)!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // add btn act
    var count = 1
    @IBAction func moreBtnAt(_ sender: UIButton) {
        if count < self.tempReviewList.count{
        self.reviewCollectionH.constant += 255
        }
        count += 1
    }
}
