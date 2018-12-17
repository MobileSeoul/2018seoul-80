package com.hyeong.handsomego.detail

import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.bumptech.glide.RequestManager
import com.hyeong.handsomego.Info
import com.hyeong.handsomego.R
import com.hyeong.handsomego.get.GetReviewResponseData2

class DetailAdapter(var reviewItems : ArrayList<GetReviewResponseData2>, var requestManager: RequestManager) :RecyclerView.Adapter<DetailViewHolder>(){
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): DetailViewHolder {
        val view : View = LayoutInflater.from(parent.context).inflate(R.layout.item_review, parent, false)
        return DetailViewHolder(view)
    }

    override fun getItemCount(): Int = reviewItems.size

    override fun onBindViewHolder(holder: DetailViewHolder, position: Int) {
        holder.reviewName.text = reviewItems[position].writer_name
        holder.reviewDate.text = reviewItems[position].comment_date.substring(0, 10).replace("-", ".")
        holder.reviewRating.rating = reviewItems[position].comment_star.toFloat()
        holder.reviewContent.text = reviewItems[position].comment_comment
        if (reviewItems[position].comment_pic1 != null) {
            holder.reviewImg1.visibility = View.VISIBLE
            requestManager.load(reviewItems[position].comment_pic1).into(holder.reviewImg1)
        }

        if (reviewItems[position].comment_pic2 != null) {
            holder.reviewImg2.visibility = View.VISIBLE
            requestManager.load(reviewItems[position].comment_pic2).into(holder.reviewImg2)
        }

        if (reviewItems[position].comment_pic3 != null) {
            holder.reviewImg1.visibility = View.VISIBLE
            requestManager.load(reviewItems[position].comment_pic3).into(holder.reviewImg3)
        }

        if (reviewItems[position].comment_pic4 != null) {
            holder.reviewImg1.visibility = View.VISIBLE
            requestManager.load(reviewItems[position].comment_pic4).into(holder.reviewImg4)
        }
    }
}