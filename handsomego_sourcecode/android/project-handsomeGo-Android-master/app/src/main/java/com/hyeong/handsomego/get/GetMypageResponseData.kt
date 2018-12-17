package com.hyeong.handsomego.get

data class GetMypageResponseData (
        var name: String,
        var picture: String,
        var stampCount: Int,
        var lastStampDate: String
)