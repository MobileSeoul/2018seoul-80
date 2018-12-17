package com.hyeong.handsomego.home

import android.support.v7.widget.RecyclerView
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import kotlinx.android.synthetic.main.rank_item.view.*

/**
 * Created by HYEON on 2018-09-24.
 */
class HomeTabRankViewHolder(itemView : View?) : RecyclerView.ViewHolder(itemView) {
    var placename : TextView = itemView!!.rank_name
    var place_category : ImageView = itemView!!.rank_color
    var placerank : TextView = itemView!!.rank_idx
}