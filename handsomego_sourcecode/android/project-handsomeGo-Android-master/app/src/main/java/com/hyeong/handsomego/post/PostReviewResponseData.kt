package com.hyeong.handsomego.post

data class PostReviewResponseData(
        var place_id : String,
        var star : String,
        var comments : String?,
        var pictures : ArrayList<String?>
)