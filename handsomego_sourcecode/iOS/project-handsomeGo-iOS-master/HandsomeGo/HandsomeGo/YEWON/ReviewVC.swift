//
//  ReviewVC.swift
//  HandsomeGo
//
//  Created by 조예원 on 27/09/2018.
//  Copyright © 2018 박세은. All rights reserved.
//
// 통신 마무리

import UIKit

class ReviewVC: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var tempPlaceId = 0
    
    @IBOutlet var starBtn: [UIButton]!
    @IBOutlet var photoImg: [UIImageView]!
    @IBOutlet weak var reviewTextView: UITextView!
    @IBOutlet weak var placeHolder: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        funcForView()
        funcForKeyboard()
        funcBtnColor()
        imagePicker.delegate = self
    }
    func funcForView(){
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        let leftButtonItem = UIBarButtonItem(image: UIImage(named: "backBtn"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(popAction))
        leftButtonItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = leftButtonItem
        self.navigationItem.title = "리뷰 하기"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "NanumSquareOTFR", size: 17)!]
        for i in 0...3{
            photoImg[i].layer.masksToBounds = true
            
            photoImg[i].layer.cornerRadius = 5
        }
    }
    @objc func popAction(){
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.popViewController(animated: true)
    }
    
    // star btn click
    var score = 1
    @IBAction func starBtnAct(_ sender: UIButton) {
        for i in 0...4{
            if i < sender.tag {
                
                UIView.animate(withDuration: 2, animations: {
                    
                    self.starBtn[i].setBackgroundImage(UIImage(named:"star.png"), for: .normal)
                }, completion: nil)
                
            }else{
                starBtn[i].setBackgroundImage(UIImage(named:"starBlank.png"), for: .normal)
            }
        }
        score = sender.tag + 1
    }
    
    // photo upload
    var numOfPic = 0
    let imagePicker = UIImagePickerController()
    var imageForProject: [UIImage] = [UIImage]()
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
                
            photoImg[numOfPic].image = selectedImage
            imageForProject.append(selectedImage)
            numOfPic+=1
            viewDidLoad()
        }
        funcBtnColor()
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func imgBtnAct(_ sender: UIButton) {
        imagePicker.allowsEditing =  false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        if numOfPic >= 4 {
            imagePicker.dismiss(animated: true, completion: nil)
            maxPicFunc()
        }
    }
    func maxPicFunc(){
        let message = UIAlertController(title: "4장 초과!", message: "사진은 4장 까지 등록 가능합니다.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
        message.addAction(action)
        self.present(message, animated: true,completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
    // textview
    func funcForKeyboard(){
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewDidChange(_ textView: UITextView) {
        placeHolder.isHidden = !reviewTextView.text.isEmpty
    }
    func textViewDidEndEditing(_ textView: UITextView)  {
        funcBtnColor()
    }
    func funcBtnColor(){
        if reviewTextView.text != "" && numOfPic > 0{
            registerBtn.backgroundColor = UIColor(red: 116.0/255.0, green: 185.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            registerBtn.isEnabled = true
        }else{
            registerBtn.backgroundColor = UIColor(red: 184.0/255.0, green: 184.0/255.0, blue: 184.0/255.0, alpha: 1.0)
            registerBtn.isEnabled = false
        }
    }
    
    // register btn act
    @IBAction func registerBtnAction(_ sender: UIButton) {
        RegisterService.reviewRegister(place_id: String(tempPlaceId), star: String(score), comments: self.reviewTextView.text, pictures: imageForProject){ (message) in
            if message == "Successful Post Comment"{
                self.popAction()
            }
        }
    }

}
