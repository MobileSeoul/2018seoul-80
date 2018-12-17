//
//  NetworkResult.swift
//  HandsomeGo
//
//  Created by 박세은 on 2018. 9. 23..
//  Copyright © 2018년 박세은. All rights reserved.
//

enum NetworkResult<T> {
    case success(T)
    case successWithNil(Int)
    case error(Int)
}
