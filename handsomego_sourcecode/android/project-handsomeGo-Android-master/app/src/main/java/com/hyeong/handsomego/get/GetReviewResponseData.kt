package com.hyeong.handsomego.get

data class GetReviewResponseData (
        var message : String,
        var status : String,
        var myComment : ArrayList<GetReviewResponseData2>,
        var comments : ArrayList<GetReviewResponseData2>
)

//"message": "로그인 해주세요. / ~님 평가해 주세요. / ~님 평가해 주세요.",
//"status": "로그인 해주세요. / 스탬프를 먼저 찎어주세요. / 별점을 평가해주세요",
//"myComment": "null / 내가 작성한 댓글",
//"comments": [
//{
//    "writer_name": "writer_name 05",
//    "comment_id": 27,
//    "writer_id": 10,
//    "comment_star": 2,
//    "comment_date": "0000-00-00 00:00:00",
//    "comment_comment": "덕수궁 돌담길 너무 좋아용",
//    "place_id": 1,
//    "comment_pic1": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
//    "comment_pic2": "https://s3.ap-northeast-2.amazonaws.com/project-handsomego/20171020_145830.jpg",
//    "comment_pic3": null,
//    "comment_pic4": null