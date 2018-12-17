package com.hyeong.handsomego.get

data class GetPlaceInfoResponseData (
        var place_id : Int,
        var place_name : String,
        var place_address : String,
        var place_content : String,
        var place_category : String,
        var place_star : Float,
        var place_pic : String,
        var commentCount : Int
)