package com.hyeong.handsomego.splash

import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.support.v7.app.AppCompatActivity
import android.view.View
import android.widget.ImageView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.engine.DiskCacheStrategy
import com.bumptech.glide.request.target.GlideDrawableImageViewTarget
import com.hyeong.handsomego.R
import com.hyeong.handsomego.login.LoginActivity

class SplashActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_splash)

        val viewImage = findViewById<View>(R.id.splash_iv) as ImageView
        val gifImage = GlideDrawableImageViewTarget(viewImage)
        Glide.with(this).load<Any>(R.drawable.handsomego_splash).diskCacheStrategy(DiskCacheStrategy.SOURCE).into(gifImage)

        val handler = Handler()
        handler.postDelayed({
            startActivity(Intent(applicationContext,LoginActivity::class.java))
            finish()
        }, 2000)
    }
}
