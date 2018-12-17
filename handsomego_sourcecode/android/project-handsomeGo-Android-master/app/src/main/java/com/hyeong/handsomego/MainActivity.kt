package com.hyeong.handsomego

import android.content.Intent
import android.os.Bundle
import android.provider.MediaStore
import android.support.v4.app.Fragment
import android.support.v7.app.AppCompatActivity
import android.view.View
import android.widget.ImageView
import android.widget.Toast
import com.google.zxing.integration.android.IntentIntegrator
import com.hyeong.handsomego.home.HomeTabFragment
import com.hyeong.handsomego.my_page.EditMypageFragment
import com.hyeong.handsomego.my_page.MypageTabFragment
import com.hyeong.handsomego.qr_code.QRcodeTabFragment
import kotlinx.android.synthetic.main.activity_main.*


class MainActivity : AppCompatActivity(), View.OnClickListener {

    override fun onClick(v: View?) {

        when(v) {
            main_icon -> {
                replaceFragment(HomeTabFragment())
                main_icon.isSelected = true
                qrcode_icon.isSelected = false
                mypage_icon.isSelected = false
            }
            qrcode_icon -> {
                if(Token.token==""){        // 게스트일시 차단
                    Toast.makeText(this,"로그인 후 가능합니다.",Toast.LENGTH_LONG).show()
                }else {
                    replaceFragment(QRcodeTabFragment())
                    main_icon.isSelected = false
                    qrcode_icon.isSelected = true
                    mypage_icon.isSelected = false
                }
            }
            mypage_icon -> {
                if(Token.token==""){        // 게스트일시 차단
                    Toast.makeText(this,"로그인 후 가능합니다.",Toast.LENGTH_LONG).show()
                }else {
                    replaceFragment(MypageTabFragment())
                    main_icon.isSelected = false
                    qrcode_icon.isSelected = false
                    mypage_icon.isSelected = true
                }
            }
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        main_icon.setOnClickListener(this)
        qrcode_icon.setOnClickListener(this)
        mypage_icon.setOnClickListener(this)

        if(GoMyPage.flag) {
            addFragment(MypageTabFragment())
            mypage_icon.isSelected = true
            GoMyPage.flag = false
        }else if(GoEdit.flag){
            addFragment(EditMypageFragment())
            mypage_icon.isSelected = true
            GoEdit.flag = false
        }else {
            addFragment(HomeTabFragment())
            main_icon.isSelected = true
        }
    }

    //Fragment 붙이는 함수
    fun addFragment(fragment: Fragment) : Unit{
        val fm = supportFragmentManager
        val transaction = fm.beginTransaction()
        transaction.add(R.id.main_frame,fragment)
        transaction.commit()
    }

    //Fragment 교체
    fun replaceFragment(fragment: Fragment) : Unit{
        val fm = supportFragmentManager
        val transaction = fm.beginTransaction()
        transaction.replace(R.id.main_frame,fragment)
        transaction.commit()
    }
}
