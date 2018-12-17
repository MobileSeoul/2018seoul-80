package com.hyeong.handsomego.get

data class GetReviewResponseData2 (
        var writer_name : String,
        var comment_id : Int,
        var writer_id : Int,
        var comment_star : Int,
        var comment_date : String,
        var comment_comment : String,
        var place_id : Int,
        var comment_pic1 : String?,
        var comment_pic2 : String?,
        var comment_pic3 : String?,
        var comment_pic4 : String?
)