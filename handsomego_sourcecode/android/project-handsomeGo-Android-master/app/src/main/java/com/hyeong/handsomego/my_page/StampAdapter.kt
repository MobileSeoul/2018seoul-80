package com.hyeong.handsomego.my_page

import android.content.Context
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.bumptech.glide.Glide
import com.hyeong.handsomego.R


/**
 * Created by HYEON on 2018-09-14.
 */
class StampAdapter (private var stampItem : ArrayList<StampItem>, val context : Context) : RecyclerView.Adapter<StampViewholder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): StampViewholder {

        val mainView : View = LayoutInflater.from(parent.context).inflate(R.layout.stamp_img,parent,false)
        return  StampViewholder(mainView)
    }

    override fun getItemCount(): Int  = stampItem.size

    override fun onBindViewHolder(holder: StampViewholder, position: Int) {
        if(stampItem[position].url!=null){
            Glide.with(context).load(stampItem[position].url).into(holder!!.stampImg)
        }else {
            holder!!.stampImg.setImageResource(stampItem[position].stamp)
        }
    }

}