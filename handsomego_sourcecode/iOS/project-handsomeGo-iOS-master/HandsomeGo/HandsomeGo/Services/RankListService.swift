//
//  PlaceListService.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 23..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct RankListService: APIService, RequestService {
    
    static let shareInstance = RankListService()
    let placeURL = url("/ranks")
    typealias NetworkData = RankListData
    
    func getRankList(completion: @escaping ([RankPlace]) -> Void, error: @escaping (Int) -> Void) {
        
        gettable(placeURL, body: nil, header: nil) { res in
            switch res {
            case .success(let rankList):
                let data = rankList.data
                completion(data)
            case .successWithNil(_):
                //데이터가 없음
                break
            case .error(let errCode):
                error(errCode)
                print("랭킹실패")
            }
        }
    }
    
    
}
