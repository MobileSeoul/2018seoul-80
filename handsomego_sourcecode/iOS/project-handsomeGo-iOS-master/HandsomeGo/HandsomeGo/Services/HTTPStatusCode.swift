//
//  HTTPStatusCode.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 23..
//  Copyright © 2018년 박세은. All rights reserved.
//

enum HTTPStatusCode: Int {
    // 200 Success
    case OK = 200 // 성공
    case Accepted = 203 // 성공 but 데이터가 없음
    
    // 400 Client Error
    case BadRequest = 400 //Bad Request
    case Unauthorized = 401 // 유저 접근 권한 없음
    case Forbidden = 403 // 인가 불가
    case NotFound = 404 // 페이지 없음
    case Conflict = 409 // 데이터 중복
    case ValidationError = 422 //처리 불가능
    case DecodingError = 423 //데이터 디코딩 에러
    
    // 500 Server Error
    case InternalServerError = 500 // 서버 에러
}
