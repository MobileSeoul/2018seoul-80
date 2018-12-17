package com.hyeong.handsomego.my_page

import android.app.Activity
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.support.v4.app.Fragment
import android.text.Editable
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import com.bumptech.glide.Glide
import com.bumptech.glide.RequestManager
import com.hyeong.handsomego.Info
import com.hyeong.handsomego.R
import com.hyeong.handsomego.Token
import com.hyeong.handsomego.applicationController.ApplicationController
import com.hyeong.handsomego.get.GetMypageResponse
import com.hyeong.handsomego.put.PutEditResponse
import com.hyeong.handsomego.put.PutEditResponseData
import kotlinx.android.synthetic.main.fragment_edit_mypage.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class EditMypageFragment : Fragment(), View.OnClickListener {
    lateinit var requesManager : RequestManager
    private val REQ_CODE_SELECT_IMAGE = 100
    lateinit var data : Uri
    val networkService = ApplicationController.instance.networkService

    override fun onClick(v: View?) {
        when (v) {
            edit_pic_iv -> {
                // 사진 업로드 통신
                changeImage()
            }
            edit_nickname_iv -> {
                // 닉네임 변경 적용 통신
                val putEditResponseData = PutEditResponseData(edit_nickname_et.text.toString(),null)
                val putEditResponse = networkService.putMypage(Token.token, putEditResponseData)
                putEditResponse.enqueue(object : Callback<PutEditResponse>{
                    override fun onFailure(call: Call<PutEditResponse>?, t: Throwable?) {
                        Log.d("asd",t.toString())
                    }

                    override fun onResponse(call: Call<PutEditResponse>?, response: Response<PutEditResponse>?) {
                        if (response!!.isSuccessful) {
                            Toast.makeText(context, "닉네임 변경 완료", Toast.LENGTH_LONG).show()
                            Info.name = edit_nickname_et.text.toString()
                        }
                    }
                })
            }
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val v = inflater.inflate(R.layout.fragment_edit_mypage,container,false)
        return v
    }

    override fun onStart() {
        super.onStart()

        edit_pic_iv.setOnClickListener(this)
        edit_nickname_iv.setOnClickListener(this)

        requesManager = Glide.with(context)

        // 프로필 사진, 닉네임 가져오기
        val getMypageResponse = networkService.getMypage(Token.token)
        getMypageResponse.enqueue(object : Callback<GetMypageResponse>{
            override fun onFailure(call: Call<GetMypageResponse>?, t: Throwable?) {
            }

            override fun onResponse(call: Call<GetMypageResponse>?, response: Response<GetMypageResponse>?) {
                if(response!!.isSuccessful){
                    requesManager.load(response.body().data.picture).into(edit_profile_circle)
                    edit_nickname_et.text = Editable.Factory.getInstance().newEditable(response.body().data.name)
                }
            }
        })
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == REQ_CODE_SELECT_IMAGE) {
            if (resultCode == Activity.RESULT_OK) {
                try {
                    this.data = data!!.data // 그 이미지의 Uri를 가져옴
                    // 이전 사진 안 보이게
                    edit_profile_circle.visibility = View.INVISIBLE
                    // 새로 고른 사진 표시 및 보이게
                    edit_change_circle.setImageURI(this.data)
                    edit_change_circle.visibility = View.VISIBLE

                    val putEditResponse = networkService.putMypage(Token.token, PutEditResponseData(null, data.data.toString()))
                    putEditResponse.enqueue(object : Callback<PutEditResponse>{
                        override fun onFailure(call: Call<PutEditResponse>?, t: Throwable?) {
                            Log.d("asd",t.toString())
                        }

                        override fun onResponse(call: Call<PutEditResponse>?, response: Response<PutEditResponse>?) {
                            if(response!!.isSuccessful)
                                Toast.makeText(context,"사진 업로드 완료",Toast.LENGTH_LONG)
                        }
                    })
                } catch (e: Exception) {
                    e.printStackTrace()
                }
            }
        }
    }
    fun changeImage() {
        var intent = Intent(Intent.ACTION_PICK)
        intent.type = android.provider.MediaStore.Images.Media.CONTENT_TYPE
        intent.data = android.provider.MediaStore.Images.Media.EXTERNAL_CONTENT_URI
        startActivityForResult(intent,REQ_CODE_SELECT_IMAGE)
    }
}
