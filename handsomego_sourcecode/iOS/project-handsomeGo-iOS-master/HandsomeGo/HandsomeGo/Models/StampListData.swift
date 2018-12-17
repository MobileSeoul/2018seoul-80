
//
//  StampListData.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 24..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Foundation

struct StampListData: Codable {
    let message: String
    let data: DataClass
}

struct DataClass: Codable {
    let status: String
    let place: [StampPlace]
}

struct StampPlace: Codable {
    let placeID: Int
    let placeName, placeAddress: String
    let placeStar: Double
    let placePic: String
    let stampStatus: Int
    let stampPic: String
    
    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case placeName = "place_name"
        case placeAddress = "place_address"
        case placeStar = "place_star"
        case placePic = "place_pic"
        case stampStatus = "stamp_status"
        case stampPic = "stamp_pic"
    }
}
