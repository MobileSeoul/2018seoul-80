//
//  MyPageData.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 23..
//  Copyright © 2018년 박세은. All rights reserved.
//

import Foundation
import Foundation

struct MypageData: Codable {
    let message: String
    let data: Profile
}

struct Profile: Codable {
    let name: String
    let picture: String
    let stampCount: Int
    let lastStampDate: String
}
