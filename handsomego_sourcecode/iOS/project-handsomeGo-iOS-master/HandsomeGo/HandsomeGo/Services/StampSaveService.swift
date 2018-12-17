
//
//  StampSaveService.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 27..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct StampSaveService: APIService, RequestService{
    
    static let shareInstance = StampSaveService()
    let URL = url("/stamps")
    typealias NetworkData = ResponseData
    
    func saveStamp(token: String, stampId: Int, completion: @escaping (String) -> Void, error: @escaping (Int) -> Void) {
        let StampURL = URL + "/\(stampId)"
        let header: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")! ,
            "Content-Type" : "application/json"
        ]
        postable(StampURL, body: nil, header: header) { (res) in
            switch res {
            case .success(let data):
                completion(data.message)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
        
    }
    
}
