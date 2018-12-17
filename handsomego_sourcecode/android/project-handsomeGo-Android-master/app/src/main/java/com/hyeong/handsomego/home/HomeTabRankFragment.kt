package com.hyeong.handsomego.home

import android.content.Intent
import android.os.Bundle
import android.support.v4.app.Fragment
import android.support.v7.widget.LinearLayoutManager
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.hyeong.handsomego.Idx
import com.hyeong.handsomego.R
import com.hyeong.handsomego.applicationController.ApplicationController
import com.hyeong.handsomego.applicationController.NetworkService
import com.hyeong.handsomego.detail.DetailActivity
import com.hyeong.handsomego.get.GetRankReviewResponse
import com.hyeong.handsomego.get.GetRankReviewResponseData
import kotlinx.android.synthetic.main.fragment_home_tab_rank.*
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

/**
 * Created by HYEON on 2018-09-24.
 */

class HomeTabRankFragment : Fragment(), View.OnClickListener{
    lateinit var rankItems : ArrayList<GetRankReviewResponseData>
    lateinit var rankAdapter : HomeTabRankAdapter
    var networkService : NetworkService = ApplicationController.instance.networkService

    override fun onClick(v: View?) {
        val idx : Int = rank_recycler.getChildAdapterPosition(v)
        Idx.place_id = rankItems[idx].place_id
        startActivity(Intent(context, DetailActivity::class.java))
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val v = inflater.inflate(R.layout.fragment_home_tab_rank, container, false)


        return v
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val getRankReview = networkService.getRankReview()
        getRankReview.enqueue(object : Callback<GetRankReviewResponse> {
            override fun onResponse(call: Call<GetRankReviewResponse>?, response: Response<GetRankReviewResponse>?) {
                Log.v("bbb","bbbbbb")
                if(response!!.isSuccessful) {
                    if(response!!.body().message.equals("Successful Get Place Rank Data")) {
                        if (response!!.body().data != null) {
                            rankItems = response.body().data
                            rankAdapter = HomeTabRankAdapter(rankItems)
                            rankAdapter.setOnItemClickListener(this@HomeTabRankFragment)
                            rank_recycler.layoutManager = LinearLayoutManager(context)
                            rank_recycler.adapter = rankAdapter
                        }
                    }
                }
            }
            override fun onFailure(call: Call<GetRankReviewResponse>?, t: Throwable?) {
                Log.v("aaa",t.toString())
            }

        })
    }

   /* fun GetRankReviewResponse() {
        val getrankreview = networkService!!.getRankReview()
        getrankreview!!.enqueue(object : retrofit2.Callback<GetRankReviewResponse> {

            override fun onResponse(call: Call<GetRankReviewResponse>?, response: Response<GetRankReviewResponse>?) {
                if(response!!.isSuccessful){
                    if(response!!.body().message.equals("Successful Get Place Rank Data")){
                        if (response!!.body().data != null){
                          //  Log.v("aaa", response!!.body().data[])
                        }
                    }
                }
            }
            override fun onFailure(call: Call<GetRankReviewResponse>?, t: Throwable?) {
                Log.v("aaa","1111111111111")

            }
        })

    }*/
}