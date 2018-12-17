//
//  RegisterService.swift
//  HandsomeGo
//
//  Created by 조예원 on 27/09/2018.
//  Copyright © 2018 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit

struct RegisterService: APIService {
    
    static func reviewRegister(place_id:String, star:String, comments:String, pictures:[UIImage], completion : @escaping (String)->Void) {
        
        let URL = url("/comments")
        let header: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")!,
            "Content-Type" : "application/json"
        ]
        
        let place_id = place_id.data(using: .utf8)
        let star = star.data(using: .utf8)
        let comments = comments.data(using: .utf8)
        
        var imgData = [UIImage]()
        for  i in 0 ..< pictures.count{
            imgData.append(pictures[i])
        }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for  i in 0 ..< pictures.count{
                let temp = UIImageJPEGRepresentation(imgData[i], 0.3)
                multipartFormData.append(temp!, withName: "pictures", fileName: "pictures.jpg", mimeType: "img/jpeg")
            }
            multipartFormData.append(place_id!, withName: "place_id")
            multipartFormData.append(star!, withName: "star")
            multipartFormData.append(comments!, withName: "comments")
        }, to: URL, method: .post, headers: header)
        { (encodingResult) in
            switch encodingResult {
                
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.responseData(completionHandler: { (res) in
                    switch res.result{
                    case .success:
                        if let value = res.result.value {
                            let message = JSON(value)["message"].string
                            if message == "Successful Post Comment"{
                                completion(message!)
                            }
                        }
                        break
                    case .failure(let err):
                        print(err.localizedDescription)
                    }
                }
                )
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
