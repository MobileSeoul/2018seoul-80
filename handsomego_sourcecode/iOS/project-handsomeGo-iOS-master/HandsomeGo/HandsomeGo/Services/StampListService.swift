//
//  StampListService.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 24..
//  Copyright © 2018년 박세은. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

struct StampListService: APIService, RequestService{
    
    static let shareInstance = StampListService()
    let URL = url("/stamps")
    typealias NetworkData = StampListData
    
    func getStampList(token: String, completion: @escaping ([StampPlace]) -> Void, error: @escaping (Int) -> Void) {
        
        let header: HTTPHeaders = [
            "Authorization" : UserDefaults.standard.string(forKey: "token")! ,
            "Content-Type" : "application/json"
        ]
        gettable(URL, body: nil, header: header) { res in
            switch res {
            case .success(let stampListData):
                let data = stampListData.data.place
                completion(data)
            case .successWithNil(_):
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
    
}
