//
//  PlaceData.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 23..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Foundation

struct PlaceListData: Codable {
    let message: String
    let data: [Place]
}
struct PlaceData: Codable {
    let message: String
    let data: Place
}

struct Place: Codable {
    let placeID: Int
    let placeName, placeAddress, placeContent, placeCategory: String
    let placeStar: Int
    let placePic: String
    let commentCount: Int
    
    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case placeName = "place_name"
        case placeAddress = "place_address"
        case placeContent = "place_content"
        case placeCategory = "place_category"
        case placeStar = "place_star"
        case placePic = "place_pic"
        case commentCount
    }
}
