
//
//  StampStatusData.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 25..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Foundation
struct StampStatusData: Codable {
    let message: String
    let data: StampStatus
}

struct StampStatus: Codable {
    
    let placeID: Int
    let placeName, placeCategory: String
    let placePic: String
    let stampDate: String
    let stampStatus: Int
    let stampPic: String
    let rank: Int
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case placeName = "place_name"
        case placeCategory = "place_category"
        case placePic = "place_pic"
        case stampDate = "stamp_date"
        case stampStatus = "stamp_status"
        case stampPic = "stamp_pic"
        case rank, status
    }
}
