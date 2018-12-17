package com.hyeong.handsomego.review

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.view.View
import android.widget.RatingBar
import android.widget.Toast
import com.hyeong.handsomego.*
import com.hyeong.handsomego.applicationController.ApplicationController
import com.hyeong.handsomego.detail.DetailActivity
import com.hyeong.handsomego.post.PostReviewResponse
import com.hyeong.handsomego.post.PostReviewResponseData
import kotlinx.android.synthetic.main.activity_review.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class ReviewActivity : AppCompatActivity(), RatingBar.OnRatingBarChangeListener {
    private val REQ_CODE_SELECT_IMAGE = 100
    var picItems : ArrayList<String?> = ArrayList()
    val networkService = ApplicationController.instance.networkService
    var tmp : Int = 0

    override fun onRatingChanged(ratingBar: RatingBar?, rating: Float, fromUser: Boolean) {
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_review)
        reviewing_rate_rating.onRatingBarChangeListener = this
        reviewing_rate_tv.text = Info.name + "님 평가해주세요."
        // 사진 업로드 버튼 눌렀을 때
        reviewing_img1_iv.setOnClickListener { v ->
            tmp = 0
            chooseImage()
        }
        reviewing_img2_iv.setOnClickListener { v ->
            tmp = 1
            chooseImage()
        }
        reviewing_img3_iv.setOnClickListener { v ->
            tmp = 2
            chooseImage()
        }
        reviewing_img4_iv.setOnClickListener { v ->
            tmp = 3
            chooseImage()
        }

        // 등록하기 버튼 눌렀을 때
        reviewing_confirm_btn.setOnClickListener { v ->
            val postReviewResponseData = PostReviewResponseData(Idx.place_id.toString(), reviewing_rate_rating.rating.toString(), reviewing_content_et.text.toString(), arrayListOf(Tmp.img1,Tmp.img2,Tmp.img3,Tmp.img4))
            val postReviewResponse = networkService.postReview(Token.token, postReviewResponseData)
            postReviewResponse.enqueue(object : Callback<PostReviewResponse>{
                override fun onFailure(call: Call<PostReviewResponse>?, t: Throwable?) {
                    Toast.makeText(applicationContext, "실패", Toast.LENGTH_LONG).show()

                }

                override fun onResponse(call: Call<PostReviewResponse>?, response: Response<PostReviewResponse>?) {
                    Toast.makeText(applicationContext, "리뷰 등록 완료" + response!!.body().message, Toast.LENGTH_LONG).show()
                    startActivity(Intent(applicationContext, DetailActivity::class.java))
                }
            })
        }
    }

    // 고른 사진의 uri 처리
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == REQ_CODE_SELECT_IMAGE) {
            if (resultCode == Activity.RESULT_OK) {
                try {
                    when (tmp) {
                        0 -> {
                            reviewing_img1_iv.setImageURI(data!!.data)
                            reviewing_img2_iv.visibility = View.VISIBLE
                            Tmp.img1 = data!!.data.toString()
                        }
                        1 -> {
                            reviewing_img2_iv.setImageURI(data!!.data)
                            reviewing_img3_iv.visibility = View.VISIBLE
                            Tmp.img2 = data!!.data.toString()
                        }
                        2 -> {
                            reviewing_img3_iv.setImageURI(data!!.data)
                            reviewing_img4_iv.visibility = View.VISIBLE
                            Tmp.img3 = data!!.data.toString()
                        }
                        3 -> {
                            reviewing_img4_iv.setImageURI(data!!.data)
                            Tmp.img4 = data!!.data.toString()
                        }
                    }
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
    }
    fun chooseImage() {
        var intent = Intent(Intent.ACTION_PICK)
        intent.type = android.provider.MediaStore.Images.Media.CONTENT_TYPE
        intent.data = android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        startActivityForResult(intent,REQ_CODE_SELECT_IMAGE)
    }
}
