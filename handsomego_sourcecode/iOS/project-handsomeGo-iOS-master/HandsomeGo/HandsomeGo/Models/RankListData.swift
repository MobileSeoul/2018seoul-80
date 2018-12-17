
//
//  RankData.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 23..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Foundation
struct RankListData: Codable {
    let message: String
    let data: [RankPlace]
}

struct RankPlace: Codable {
    let placeID: Int
    let placeName: String
    let placeStar: Double
    let placeCategory: String
    
    enum CodingKeys: String, CodingKey {
        case placeID = "place_id"
        case placeName = "place_name"
        case placeStar = "place_star"
        case placeCategory = "place_category"
    }
}
