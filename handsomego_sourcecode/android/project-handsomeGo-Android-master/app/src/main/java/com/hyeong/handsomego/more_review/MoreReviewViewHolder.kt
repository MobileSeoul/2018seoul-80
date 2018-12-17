package com.hyeong.handsomego.more_review

import android.support.v7.widget.RecyclerView
import android.view.View
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import kotlinx.android.synthetic.main.item_review.view.*

class MoreReviewViewHolder(itemView: View?) : RecyclerView.ViewHolder(itemView){
    var reviewName : TextView = itemView!!.review_name_tv
    var reviewDate : TextView = itemView!!.review_date_tv
    var reviewRating : RatingBar = itemView!!.review_rating_rating
    var reviewContent : TextView = itemView!!.review_content_tv
    var reviewImg1 : ImageView = itemView!!.review_img1_iv
    var reviewImg2 : ImageView = itemView!!.review_img2_iv
    var reviewImg3 : ImageView = itemView!!.review_img3_iv
    var reviewImg4 : ImageView = itemView!!.review_img4_iv
}