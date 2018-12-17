//
//  ReviewService.swift
//  HandsomeGo
//
//  Created by 조예원 on 27/09/2018.
//  Copyright © 2018 박세은. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON
import UIKit

struct ReviewService:APIService {
    static func getReivew(id:Int, completion: @escaping ([ReviewList],String, String, [ReviewList]?)->Void){
        let URL = url("/places/\(id)/comments")
        
        let header: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")! ,
            "Content-Type" : "application/json"
        ]
                Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).responseData() {res in
            switch res.result{
            case .success:
                if let value = res.result.value{
                    let decoder = JSONDecoder()
                    do{
                        let data = try decoder.decode(ReviewResponse.self, from: value)
                        if data.message == "Successful Get Comment List Data"{
                            completion(data.data.comments, data.data.message ?? "", data.data.status ?? "", data.data.myComment)
                        }
                    }catch{print("decoding err")}
                }
                break
            case .failure(let err):
                print(err.localizedDescription)
                print("reviewDetail err")
                break
            }
        }
    }
}
