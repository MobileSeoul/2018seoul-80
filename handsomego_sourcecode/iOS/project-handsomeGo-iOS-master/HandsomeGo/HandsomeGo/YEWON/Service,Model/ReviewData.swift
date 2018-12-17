//
//  ReviewData.swift
//  HandsomeGo
//
//  Created by 조예원 on 27/09/2018.
//  Copyright © 2018 박세은. All rights reserved.
//

import Foundation

struct ReviewResponse: Codable{
    let message: String
    let data : ReviewListData
}

struct ReviewListData: Codable{
    let message: String?
    let status: String?
    let myComment: [ReviewList]?
    let comments: [ReviewList]
}

struct ReviewList: Codable{
    let writer_name: String
    let comment_id, writer_id, comment_star: Int
    let comment_date: String
    let comment_comment: String?
    let place_id: Int
    let comment_pic1, comment_pic2, comment_pic3, comment_pic4: String?
}
