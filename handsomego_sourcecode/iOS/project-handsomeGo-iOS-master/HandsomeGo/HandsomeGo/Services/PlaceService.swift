//
//  PlaceService.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 23..
//  Copyright © 2018년 박세은. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

struct PlaceService: APIService, RequestService {
    static let shareInstance = PlaceService()
    let placeURL = url("/places")
    typealias NetworkData = PlaceData
    
    func getPlace(placeId: Int, completion: @escaping (Place) -> Void, error: @escaping (Int) -> Void) {
        let URL = placeURL + "/\(placeId)"
        gettable(URL, body: nil, header: nil) { res in
            switch res {
            case .success(let placeList):
                let data = placeList.data
                completion(data)
            case .successWithNil(_):
                //데이터가 없음
                break
            case .error(let errCode):
                error(errCode)
            }
        }
    }
}

