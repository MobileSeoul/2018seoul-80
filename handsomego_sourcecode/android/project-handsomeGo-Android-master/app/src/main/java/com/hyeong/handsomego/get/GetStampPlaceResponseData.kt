package com.hyeong.handsomego.get

data class GetStampPlaceResponseData (
    var place_id : Int,
    var place_name : String,
    var place_category : String,
    var place_pic : String,
    var stamp_date : String,
    var stamp_status : Int,
    var stamp_pic : String,
    var rank : Int,
    var status : String
)