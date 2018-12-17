package com.hyeong.handsomego.get

/**
 * Created by HYEON on 2018-09-19.
 */
data class GetStampInfoResponseData2 (
        var place_id : Int,
        var place_name : String,
        var place_address : String,
        var place_star : Float,
        var place_pic : String,
        var stamp_status : Int,
        var stamp_pic : String
)