package com.hyeong.handsomego.applicationController

import android.app.Application
import com.hyeong.handsomego.kakao.GlobalApplication
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory


/**
 * Created by HYEON on 2018-09-19.
 */
class ApplicationController : GlobalApplication(){
    lateinit var networkService: NetworkService
    private val baseUrl = "http://bghgu.tk:3000/api/"

    companion object {
        lateinit var instance : ApplicationController
    }
    override fun onCreate() {
        super.onCreate()
        instance = this
        buildNetwork()
    }

    fun buildNetwork() {
        val builder = Retrofit.Builder()
        val retrofit = builder
                .baseUrl(baseUrl)
                .addConverterFactory(GsonConverterFactory.create())
                .build()
        networkService = retrofit.create(NetworkService::class.java)
    }
}