package com.hyeong.handsomego.after_stamp

import android.content.Intent
import android.graphics.Color
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.WindowManager
import com.bumptech.glide.Glide
import com.bumptech.glide.RequestManager
import com.hyeong.handsomego.Idx
import com.hyeong.handsomego.R
import com.hyeong.handsomego.Token
import com.hyeong.handsomego.applicationController.ApplicationController
import com.hyeong.handsomego.applicationController.NetworkService
import com.hyeong.handsomego.get.GetPlaceInfoResponse
import com.hyeong.handsomego.post.PostStampPlaceResponse
import kotlinx.android.synthetic.main.activity_detail.*
import kotlinx.android.synthetic.main.activity_simple_info.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class SimpleInfoActivity : AppCompatActivity() {
    var networkService : NetworkService= ApplicationController.instance.networkService
    lateinit var requestManager : RequestManager
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_simple_info)
        requestManager = Glide.with(this)
        // Full Screen
        window.setFlags(WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS, WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS)
        window.statusBarColor = Color.TRANSPARENT

        // Get Place Info
        val getPlaceInfoResponse = networkService.getPlaceInfo(Idx.place_id)
        getPlaceInfoResponse.enqueue(object : Callback<GetPlaceInfoResponse>{
            override fun onFailure(call: Call<GetPlaceInfoResponse>?, t: Throwable?) {
            }

            override fun onResponse(call: Call<GetPlaceInfoResponse>?, response: Response<GetPlaceInfoResponse>?) {
                if(response!!.isSuccessful){
                    when {
                        response.body().data.place_category == "역사 문화" -> simple_cate_iv.setBackgroundColor(Color.parseColor("#fb8b20"))
                        response.body().data.place_category == "도시 건축" -> simple_cate_iv.setBackgroundColor(Color.parseColor("#549b0e"))
                        response.body().data.place_category == "과학 경제" -> simple_cate_iv.setBackgroundColor(Color.parseColor("#5ba2f6"))
                    }
                    simple_name_tv.text = response.body().data.place_name
                    simple_address_tv.text = response.body().data.place_address
                    simple_info_tv.text = response.body().data.place_content
                    simple_review_tv.text = response.body().data.commentCount.toString()
                    requestManager.load(response.body().data.place_pic).into(simple_img_iv)
                }
            }
        })

        simple_get_btn.setOnClickListener { v ->
            val postStampResponse = networkService.postStampPlace(Token.token, Idx.place_id)
            postStampResponse.enqueue(object : Callback<PostStampPlaceResponse>{
                override fun onFailure(call: Call<PostStampPlaceResponse>?, t: Throwable?) {
                }

                override fun onResponse(call: Call<PostStampPlaceResponse>?, response: Response<PostStampPlaceResponse>?) {
                }
            })
            startActivity(Intent(applicationContext, AfterStampActivity::class.java))
        }
    }
}
