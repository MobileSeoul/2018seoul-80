package com.hyeong.handsomego.kakao

import android.content.Context
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.util.Log
import com.hyeong.handsomego.Token
import com.hyeong.handsomego.applicationController.ApplicationController
import com.hyeong.handsomego.login.LoginActivity
import com.hyeong.handsomego.post.PostLoginData
import com.hyeong.handsomego.post.PostLoginResponse
import com.kakao.auth.ISessionCallback
import com.kakao.network.ErrorResult
import com.kakao.usermgmt.UserManagement
import com.kakao.usermgmt.callback.MeResponseCallback
import com.kakao.usermgmt.response.model.UserProfile
import com.kakao.util.exception.KakaoException
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import com.hyeong.handsomego.MainActivity
import android.content.Intent




class SessionCallback(mContext : Context) : ISessionCallback{
    var mContext: Context = mContext
    val networkService = ApplicationController.instance.networkService
    // 로그인에 실패
    override fun onSessionOpenFailed(exception: KakaoException?) {
    }

    // 로그인에 성공
    override fun onSessionOpened() {
        requestMe()
    }
    fun requestMe(){
        val user : UserManagement = UserManagement.getInstance()
        user.requestMe(object : MeResponseCallback(){
            override fun onSuccess(result: UserProfile?) {
                val nickname = result!!.nickname
                val profileImagePath = result.profileImagePath
                val UUID = result.uuid


                val postLoginResponse = networkService.postLogin(PostLoginData(UUID, nickname, profileImagePath))
                postLoginResponse.enqueue(object : Callback<PostLoginResponse>{
                    override fun onFailure(call: Call<PostLoginResponse>?, t: Throwable?) {
                    }

                    override fun onResponse(call: Call<PostLoginResponse>?, response: Response<PostLoginResponse>?) {
                        if(response!!.isSuccessful) {
                            Token.token = response.body().token!!
                            mContext.startActivity(Intent(mContext, MainActivity::class.java))
                        }
                    }

                })
            }

            override fun onSessionClosed(errorResult: ErrorResult?) {
                Log.e("SessionCallback :: ", "onSessionClosed : " + errorResult!!.errorMessage);
            }

            override fun onNotSignedUp() {
                Log.e("SessionCallback :: ", "onNotSignedUp");
            }
        })
    }
}