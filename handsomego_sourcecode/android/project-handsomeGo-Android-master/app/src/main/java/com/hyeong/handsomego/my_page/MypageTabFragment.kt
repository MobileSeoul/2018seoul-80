package com.hyeong.handsomego.my_page

import android.content.Intent
import android.os.Bundle
import android.support.v4.app.Fragment
import android.support.v7.widget.GridLayoutManager
import android.support.v7.widget.RecyclerView
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import com.bumptech.glide.Glide
import com.hyeong.handsomego.*
import com.hyeong.handsomego.applicationController.ApplicationController
import com.hyeong.handsomego.get.GetMypageResponse
import com.hyeong.handsomego.get.GetStampInfoResponse
import com.hyeong.handsomego.login.LoginActivity
import kotlinx.android.synthetic.main.fragment_mypagetab.*
import kotlinx.android.synthetic.main.fragment_mypagetab.view.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

/**
 * Created by HYEON on 2018-09-03.
 */
class MypageTabFragment : Fragment(), View.OnClickListener {
    lateinit var stampItem: ArrayList<StampItem>
    lateinit var  stampAdapter: StampAdapter
    override fun onClick(v: View?) {
        when (v) {
            mypage_edit_iv -> {
                GoEdit.flag = true
                startActivity(Intent(context,MainActivity::class.java))
            }
            stamp_more_btn -> {
                mypage_stamp_relative.visibility = View.VISIBLE
                stamp_nomore_btn.visibility = View.VISIBLE
                stamp_more_btn.visibility = View.GONE
            }
            stamp_nomore_btn -> {
                mypage_stamp_relative.visibility = View.GONE
                stamp_nomore_btn.visibility = View.GONE
                stamp_more_btn.visibility = View.VISIBLE
            }
            logout_btn -> {
                Token.token = ""
                Toast.makeText(context, "로그아웃 되었습니다.", Toast.LENGTH_SHORT).show()
                startActivity(Intent(context, LoginActivity::class.java))
            }
        }
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val v = inflater.inflate(R.layout.fragment_mypagetab,container,false)
        return v
    }

    override fun onStart() {
        super.onStart()

        mypage_edit_iv.setOnClickListener(this)
        stamp_more_btn.setOnClickListener(this)
        stamp_nomore_btn.setOnClickListener(this)
        logout_btn.setOnClickListener(this)

        val requestManager = Glide.with(context)

        val networkService = ApplicationController.instance.networkService

        val getMypageResponse = networkService.getMypage(Token.token)
        getMypageResponse.enqueue(object : Callback<GetMypageResponse>{
            override fun onFailure(call: Call<GetMypageResponse>?, t: Throwable?) {
            }

            override fun onResponse(call: Call<GetMypageResponse>?, response: Response<GetMypageResponse>?) {
                if(response!!.isSuccessful){
                    requestManager.load(response.body().data.picture).into(mypage_profile_circle)
                    mypage_nickname_tv.text = response.body().data.name
                    Info.name = mypage_nickname_tv.text.toString()
                    mypage_date_tv.text = response.body().data.lastStampDate.substring(0,10).replace("-",".")
                    mypage_count_tv.text = response.body().data.stampCount.toString()+"/20"
                }
            }
        })

        val stamp_recycler : RecyclerView = view!!.findViewById(R.id.stamp_recycler)

        stampItem = ArrayList()
        stampItem.add(StampItem(R.drawable.stamp_doldamgil_gray))
        stampItem.add(StampItem(R.drawable.stamp_culturestocking_gray))
        stampItem.add(StampItem(R.drawable.stamp_underbunker_gray))
        stampItem.add(StampItem(R.drawable.stamp_gyeongchun_gray))
        stampItem.add(StampItem(R.drawable.stamp_bongjae_gray))
        stampItem.add(StampItem(R.drawable.stamp_50_plus_gray))
        stampItem.add(StampItem(R.drawable.stamp_hamsangpark_gray))
        stampItem.add(StampItem(R.drawable.stamp_seoulgarden_gray))
        stampItem.add(StampItem(R.drawable.stamp_newplaza_gray))
        stampItem.add(StampItem(R.drawable.stamp_hasudo))
        stampItem.add(StampItem(R.drawable.stamp_biohub_gray))
        stampItem.add(StampItem(R.drawable.stamp_carindustry))
        stampItem.add(StampItem(R.drawable.stamp_innohub_gray))
        stampItem.add(StampItem(R.drawable.stamp_innopark_gray))
        stampItem.add(StampItem(R.drawable.stamp_seoulscience_gray))
        stampItem.add(StampItem(R.drawable.stamp_entrepreneurshiphub))
        stampItem.add(StampItem(R.drawable.stamp_seoullo_gray))
        stampItem.add(StampItem(R.drawable.stamp_donuimun_gray))
        stampItem.add(StampItem(R.drawable.stamp_seoulbiennale_gray))
        stampItem.add(StampItem(R.drawable.stamp_sewoon_gray))


        stampAdapter = StampAdapter(stampItem, context!!)
        stamp_recycler.layoutManager = GridLayoutManager(context,4)
        stamp_recycler.adapter = stampAdapter


        val getStampInfoResponse = networkService.getStampInfo(Token.token)
        getStampInfoResponse.enqueue(object : Callback<GetStampInfoResponse> {
            override fun onFailure(call: Call<GetStampInfoResponse>?, t: Throwable?) {
                Log.d("asd",t.toString())
            }

            override fun onResponse(call: Call<GetStampInfoResponse>?, response: Response<GetStampInfoResponse>?) {
                if(response!!.isSuccessful){
                    val stampImgs :ArrayList<Int> = arrayListOf(
                            R.drawable.stamp_doldamgil_big,
                            R.drawable.stamp_culturestocking_big,
                            R.drawable.stamp_underbunker_big,
                            R.drawable.stamp_gyeongchun_big,
                            R.drawable.stamp_bongjae_big,
                            R.drawable.stamp_50_plus_big,
                            R.drawable.stamp_hamsangpark_big,
                            R.drawable.stamp_seoulgarden_big,
                            R.drawable.stamp_newplaza_big,
                            R.drawable.stamp_hasudo_big,
                            R.drawable.stamp_biohub_big,
                            R.drawable.stamp_carindustry_big,
                            R.drawable.stamp_innohub_big,
                            R.drawable.stamp_innopark_big,
                            R.drawable.stamp_seoulscience_big,
                            R.drawable.stamp_entrepreneurshiphub_big,
                            R.drawable.stamp_seoullo_big,
                            R.drawable.stamp_donuimun_big,
                            R.drawable.stamp_seoulbiennale_big,
                            R.drawable.stamp_sewoon_big
                    )
                    for(i in 0..19){
                        if(response.body().data.place[i].stamp_status==1)
                            stampItem[i]= StampItem(stampImgs[i])
                    }
                    stamp_recycler.adapter = stampAdapter
                }
            }
        })
    }
}
