package com.hyeong.handsomego.get

/**
 * Created by HYEON on 2018-09-24.
 */
data class GetSpaceData (
        var place_id : Int,
        var place_name : String,
        var place_address : String,
        var place_content : String,
        var place_category : String,
        var place_star : Double,
        var place_pic : String,
        var commentCount: Int
)