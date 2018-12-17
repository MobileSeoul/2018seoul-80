
//
//  MyPageService.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 23..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct MyPageService: APIService, RequestService{
    static let shareInstance = MyPageService()
    let URL = url("/mypage")
    typealias NetworkData = MypageData
    
    func getMyPage(token: String, completion: @escaping (Profile) -> Void, error: @escaping (Int) -> Void) {
       
        let header: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")! ,
            "Content-Type" : "application/json"
        ]
        gettable(URL, body: nil, header: header) { res in
            switch res {
            case .success(let productData):
                
                let data = productData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
    func changeMyPage(token: String, name: String, photo: UIImage?, completion: @escaping () -> Void){
        let header: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")! ,
            "Content-Type" : "application/json"
        ]
        
        let nameData = name.data(using: .utf8)
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            multipartFormData.append(nameData!, withName: "name")
            
            if let photo = photo {
                let photoData = UIImageJPEGRepresentation(photo, 0.3)
                
                multipartFormData.append(photoData!, withName: "picture", fileName: "photo.jpg", mimeType: "image/jpeg")
            }
            
        }, to: URL, method: .put, headers: header ){ (encodingResult) in
            switch encodingResult {
            case .success(request: let upload, streamingFromDisk: _ , streamFileURL: _ ):
                upload.responseData(completionHandler: { (res) in
                    switch res.result {
                    case .success:
                        completion()
                        
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                })
                
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
}
