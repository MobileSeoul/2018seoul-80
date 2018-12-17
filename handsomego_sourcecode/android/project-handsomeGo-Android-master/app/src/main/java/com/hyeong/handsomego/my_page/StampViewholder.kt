package com.hyeong.handsomego.my_page

import android.support.v7.widget.RecyclerView
import android.view.View
import android.widget.ImageView
import com.hyeong.handsomego.R

/**
 * Created by HYEON on 2018-09-14.
 */
class StampViewholder(itemView: View) : RecyclerView.ViewHolder(itemView) {
   var stampImg : ImageView = itemView!!.findViewById(R.id.stamp_img) as ImageView
}