
//
//  StampStatusService.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct StampStatusService: APIService, RequestService{
    
    static let shareInstance = StampStatusService()
    let URL = url("/stamps")
    typealias NetworkData = StampStatusData
    
    func getStampStatus(token: String, stampId: Int, completion: @escaping (StampStatus) -> Void, error: @escaping (Int) -> Void) {
        let StampURL = URL + "/\(stampId)"
        let header: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")! ,
            "Content-Type" : "application/json"
        ]
        gettable(StampURL, body: nil, header: header) { res in
            switch res {
            case .success(let stampStatusData):
                let data = stampStatusData.data
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
