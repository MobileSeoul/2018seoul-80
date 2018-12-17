package com.hyeong.handsomego.after_stamp

import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import com.bumptech.glide.Glide
import com.bumptech.glide.RequestManager
import com.hyeong.handsomego.*
import com.hyeong.handsomego.applicationController.ApplicationController
import com.hyeong.handsomego.applicationController.NetworkService
import com.hyeong.handsomego.get.GetStampPlaceResponse
import kotlinx.android.synthetic.main.activity_after_stamp.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class AfterStampActivity : AppCompatActivity() {
    var networkService : NetworkService = ApplicationController.instance.networkService
    lateinit var requestManager : RequestManager
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_after_stamp)

        requestManager = Glide.with(this)

        // Get Stamp of Place Info
        val getPlacePlaceResponse = networkService.getStampPlace(Token.token, Idx.place_id)
        getPlacePlaceResponse.enqueue(object : Callback<GetStampPlaceResponse> {
            override fun onFailure(call: Call<GetStampPlaceResponse>?, t: Throwable?) {
            }

            override fun onResponse(call: Call<GetStampPlaceResponse>?, response: Response<GetStampPlaceResponse>?) {
                if(response!!.isSuccessful){
                    after_title_tv.text = response.body().data.place_name
                    after_cate_tv.text = response.body().data.place_category
                    after_rank_tv.text = response.body().data.rank.toString()+"위"
                    after_date_tv.text = response.body().data.stamp_date.substring(0,10).replace("-",".")
                    requestManager.load(response.body().data.stamp_pic).into(after_stamp_circle)
                }
            }
        })

        after_goto_btn.setOnClickListener { v ->
            GoMyPage.flag = true
            startActivity(Intent(applicationContext, MainActivity::class.java))
        }
    }
}
