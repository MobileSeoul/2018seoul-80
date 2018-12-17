package com.hyeong.handsomego.kakao

import android.app.Application
import com.kakao.auth.KakaoSDK


open class GlobalApplication() : Application() {
    override fun onCreate() {
        super.onCreate()
        instance = this
        // Kakao Sdk 초기화
        KakaoSDK.init(KakaoSDKAdapter())
    }
    override fun onTerminate() {
        super.onTerminate()
        instance = null
    }
    companion object {
        private var instance: GlobalApplication? = null
        val globalApplicationContext: GlobalApplication
            get() {
                if (instance == null) {
                    throw IllegalStateException("This Application does not inherit com.kakao.GlobalApplication")
                }
                return instance as GlobalApplication
            }
    }

}

