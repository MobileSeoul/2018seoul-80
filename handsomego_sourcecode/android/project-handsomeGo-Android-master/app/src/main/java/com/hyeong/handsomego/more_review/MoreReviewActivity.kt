package com.hyeong.handsomego.more_review

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.support.v7.widget.LinearLayoutManager
import com.bumptech.glide.Glide
import com.hyeong.handsomego.Idx
import com.hyeong.handsomego.R
import com.hyeong.handsomego.applicationController.ApplicationController
import com.hyeong.handsomego.applicationController.NetworkService
import com.hyeong.handsomego.get.GetMoreReviewResponse
import com.hyeong.handsomego.get.GetMoreReviewResponseData
import kotlinx.android.synthetic.main.activity_more_review.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class MoreReviewActivity : AppCompatActivity() {
    lateinit var reviewItems : ArrayList<GetMoreReviewResponseData>
    lateinit var reviewAdapter : MoreReviewAdapter
    var networkService : NetworkService = ApplicationController.instance.networkService
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_more_review)

        var requestManager = Glide.with(this)

        val getMoreReview = networkService.getMoreReview(Idx.place_id)
        getMoreReview.enqueue(object: Callback<GetMoreReviewResponse>{
            override fun onFailure(call: Call<GetMoreReviewResponse>?, t: Throwable?) {
            }

            override fun onResponse(call: Call<GetMoreReviewResponse>?, response: Response<GetMoreReviewResponse>?) {
                if(response!!.isSuccessful){
                    reviewItems = response.body().data
                    reviewAdapter = MoreReviewAdapter(reviewItems, requestManager)
                    morerv_review_recycler.layoutManager = LinearLayoutManager(this@MoreReviewActivity)
                    morerv_review_recycler.adapter = reviewAdapter
                }
            }

        })
    }
}