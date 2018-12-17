package com.hyeong.handsomego.home

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.support.v4.app.Fragment
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import com.bumptech.glide.Glide
import com.hyeong.handsomego.Idx
import com.hyeong.handsomego.R
import com.hyeong.handsomego.applicationController.ApplicationController
import com.hyeong.handsomego.applicationController.NetworkService
import com.hyeong.handsomego.detail.DetailActivity
import com.hyeong.handsomego.get.GetSpaceData
import com.hyeong.handsomego.get.GetSpaceResponse
import pl.polidea.view.ZoomView
import retrofit2.Call
import retrofit2.Response

/**
 * Created by HYEON on 2018-09-24.
 */

class HomeTabMapFragment : Fragment(), View.OnClickListener {

    private var networkService : NetworkService? = null
    private var specificSpaceInfo = ArrayList<GetSpaceData>()
    private var space_info_layout : RelativeLayout? = null
    private var zoomView: ZoomView? = null
    private var star_rating : RatingBar? = null

    //Relative Layout 가져오기
    private var map_space_name: TextView? = null
    private var map_space_addr: TextView? = null
    private var star_text : TextView? = null
    private var map_img : ImageView? = null

    // 버튼 가져오기 yellow section
    var yellow1 : Button? = null
    var yellow2 : Button? = null
    var yellow3 : Button? = null
    var yellow4 : Button? = null
    var yellow5 : Button? = null
    var yellow6 : Button? = null
    var yellow7 : Button? = null
    var yellow8 : Button? = null
    //버튼 가져오기 blue section
    var blue1 : Button? = null
    var blue2 : Button? = null
    var blue3 : Button? = null
    var blue4 : Button? = null
    var blue5 : Button? = null
    var blue6 : Button? = null
    var blue7 : Button? = null
    var blue8 : Button? = null
    //버튼 가져오기 green section
    var green1 : Button? = null
    var green2 : Button? = null
    var green3 : Button? = null
    var green4 : Button? = null

    //private var networkService : NetworkService? = null

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val v = inflater.inflate(R.layout.fragment_home_tab_map,container,false)
        val view = (context!!.getSystemService(Context.LAYOUT_INFLATER_SERVICE)as LayoutInflater).inflate(R.layout.fragment_hometab_zoomview,null,false)
        val layoutParams = LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT)

        networkService = ApplicationController.instance!!.networkService

        //레이아웃 가져오기
        space_info_layout = v!!.findViewById(R.id.space_info_layout)
        map_space_name = v!!.findViewById(R.id.map_space_name)
        map_space_name = v!!.findViewById(R.id.map_space_name)
        map_space_addr = v!!.findViewById(R.id.map_space_addr)
        star_text = v!!.findViewById(R.id.star_text)
        map_img = v!!.findViewById(R.id.map_img)

        // 버튼 가져오기 yellow section
        yellow1 = view!!.findViewById<Button>(R.id.yellow1)
        yellow2 = view!!.findViewById<Button>(R.id.yellow2)
        yellow3 = view!!.findViewById<Button>(R.id.yellow3)
        yellow4 = view!!.findViewById<Button>(R.id.yellow4)
        yellow5 = view!!.findViewById<Button>(R.id.yellow5)
        yellow6 = view!!.findViewById<Button>(R.id.yellow6)
        yellow7 = view!!.findViewById<Button>(R.id.yellow7)
        yellow8 = view!!.findViewById<Button>(R.id.yellow8)
        //버튼 가져오기 blue section
        blue1 = view!!.findViewById<Button>(R.id.blue1)
        blue2 = view!!.findViewById<Button>(R.id.blue2)
        blue3 = view!!.findViewById<Button>(R.id.blue3)
        blue4 = view!!.findViewById<Button>(R.id.blue4)
        blue5 = view!!.findViewById<Button>(R.id.blue5)
        blue6 = view!!.findViewById<Button>(R.id.blue6)
        blue7 = view!!.findViewById<Button>(R.id.blue7)
        blue8 = view!!.findViewById<Button>(R.id.blue8)
        //버튼 가져오기 green section
        green1 = view!!.findViewById<Button>(R.id.green1)
        green2 = view!!.findViewById<Button>(R.id.green2)
        green3 = view!!.findViewById<Button>(R.id.green3)
        green4 = view!!.findViewById<Button>(R.id.green4)

        zoomView = ZoomView(context)
        zoomView!!.addView(view)
        zoomView!!.layoutParams = layoutParams

        //zoomView!!.isMiniMapEnabled = true // 좌측 상단 검은색 미니맵 설정
        zoomView!!.maxZoom = 4f
        zoomView!!.miniMapCaption = "Mini Map Test" // 미니맵 내용
        zoomView!!.miniMapCaptionSize = 20f // 미니맵 내용 글씨 크기 설정

        val container = v!!.findViewById<RelativeLayout>(R.id.mapContainer)
        container.addView(zoomView)

        //클릭 리스너 달기
        yellow1!!.setOnClickListener(this)
        yellow2!!.setOnClickListener(this)
        yellow3!!.setOnClickListener(this)
        yellow4!!.setOnClickListener(this)
        yellow5!!.setOnClickListener(this)
        yellow6!!.setOnClickListener(this)
        yellow7!!.setOnClickListener(this)
        yellow8!!.setOnClickListener(this)

        blue1!!.setOnClickListener(this)
        blue2!!.setOnClickListener(this)
        blue3!!.setOnClickListener(this)
        blue4!!.setOnClickListener(this)
        blue5!!.setOnClickListener(this)
        blue6!!.setOnClickListener(this)
        blue7!!.setOnClickListener(this)
        blue8!!.setOnClickListener(this)

        green1!!.setOnClickListener(this)
        green2!!.setOnClickListener(this)
        green3!!.setOnClickListener(this)
        green4!!.setOnClickListener(this)
        // zoomView 클릭시 팝업 해제를 위한 리스너
        zoomView!!.setOnClickListener(this)
        // 맨처음 뜨는 팝업 invisible
        space_info_layout!!.visibility = View.GONE
        // 팝업 클릭시 화면 전환을 위한 리스너
        space_info_layout!!.setOnClickListener(this)

        //Rating Bar setting
        star_rating = v!!.findViewById<RatingBar>(R.id.star_rating)

        return v

    }

    override fun onClick(v: View?) {
        when(v){
            yellow1 ->{ //8
                isVisibleLayout()
                getSpaceInfo(8)
            }
            yellow2 ->{ //6
                isVisibleLayout()
                getSpaceInfo(6)
            }
            yellow3 ->{ //7
                isVisibleLayout()
                getSpaceInfo(7)
            }
            yellow4 ->{ //2
                isVisibleLayout()
                getSpaceInfo(2)
            }
            yellow5 ->{ //3
                isVisibleLayout()
                getSpaceInfo(3)
            }
            yellow6 ->{ //1
                isVisibleLayout()
                getSpaceInfo(1)
            }
            yellow7 ->{ //4
                isVisibleLayout()
                getSpaceInfo(4)
            }
            yellow8 ->{ //5
                isVisibleLayout()
                getSpaceInfo(5)
            }
            blue1 -> { //14
                isVisibleLayout()
                getSpaceInfo(14)
            }
            blue2 -> { //16
                isVisibleLayout()
                getSpaceInfo(16)
            }
            blue3 -> { //12
                isVisibleLayout()
                getSpaceInfo(12)
            }
            blue4 -> { //10
                isVisibleLayout()
                getSpaceInfo(10)
            }
            blue5 -> { //9
                isVisibleLayout()
                getSpaceInfo(9)
            }
            blue6 -> { //13
                isVisibleLayout()
                getSpaceInfo(13)
            }
            blue7 -> { //15
                isVisibleLayout()
                getSpaceInfo(15)
            }
            blue8 -> { //11
                isVisibleLayout()
                getSpaceInfo(11)
            }
            green1 ->{ //18
                isVisibleLayout()
                getSpaceInfo(18)
            }
            green2 ->{ //17
                isVisibleLayout()
                getSpaceInfo(17)
            }
            green3 ->{ //20
                isVisibleLayout()
                getSpaceInfo(20)
            }
            green4 ->{ //19
                isVisibleLayout()
                getSpaceInfo(19)
            }
            space_info_layout ->{
                startActivity(Intent(context,DetailActivity::class.java))
            }
            else ->{
                space_info_layout!!.visibility = View.GONE
            }
        }
    }

    private fun isVisibleLayout() {
        space_info_layout!!.bringToFront()
        space_info_layout!!.visibility = View.VISIBLE
    }

    fun getSpaceInfo(place_id : Int) {
        Log.v("dek","place_id : "+ place_id)
        // 추후 화면 전환을 위한 id값 전달
        Idx.place_id = place_id
        specificSpaceInfo.clear()
        val spaceInfobyIdResponse = networkService!!.getSpaceInfo(place_id)
        spaceInfobyIdResponse!!.enqueue(object : retrofit2.Callback<GetSpaceResponse> {
            override fun onResponse(call: Call<GetSpaceResponse>?, response: Response<GetSpaceResponse>?) {
                if(response!!.isSuccessful){
                    if(response!!.body().message.equals("Successful Get Place Data")){
                        if (response!!.body().data != null){
                            Log.v("dek",response!!.body().data.place_id.toString() + " : data.place_id")
                            specificSpaceInfo.add(GetSpaceData(response!!.body().data.place_id,
                                    response!!.body().data.place_name,
                                    response!!.body().data.place_address,
                                    response!!.body().data.place_content,
                                    response!!.body().data.place_category,
                                    response!!.body().data.place_star,
                                    response!!.body().data.place_pic,
                                    response!!.body().data.commentCount))

                            Glide.with(this@HomeTabMapFragment).load(specificSpaceInfo[0].place_pic).into(map_img)
                            map_space_name!!.text = specificSpaceInfo[0].place_name
                            map_space_addr!!.text = specificSpaceInfo[0].place_address
                            star_text!!.text = specificSpaceInfo[0].place_star.toString()
                            star_rating!!.rating = specificSpaceInfo[0].place_star.toFloat()

                        }else{
                            Log.v("dek","data is null")
                        }
                    }else{
                        Log.v("dek","Cannot get place data")
                    }
                }else{
                    Log.v("dek","response is not successful")
                }
            }
            override fun onFailure(call: Call<GetSpaceResponse>?, t: Throwable?) {
                Log.v("dek","failure")
            }

        })
    }

}
