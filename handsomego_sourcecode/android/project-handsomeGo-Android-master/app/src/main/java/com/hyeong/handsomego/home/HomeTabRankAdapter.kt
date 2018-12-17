package com.hyeong.handsomego.home

import android.graphics.Color
import android.support.v7.widget.RecyclerView
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.hyeong.handsomego.R
import com.hyeong.handsomego.get.GetRankReviewResponseData


/**
 * Created by HYEON on 2018-09-24.
 */
class HomeTabRankAdapter(var rankItems : ArrayList<GetRankReviewResponseData>) : RecyclerView.Adapter<HomeTabRankViewHolder>() {

    private lateinit var onItemClick : View.OnClickListener

    fun setOnItemClickListener(l : View.OnClickListener){ //3. 외부에서 넘어온 클릭리스너 설정
        onItemClick = l
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): HomeTabRankViewHolder {
        val view : View = LayoutInflater.from(parent.context).inflate(R.layout.rank_item, parent, false)
        view.setOnClickListener(onItemClick)
        return HomeTabRankViewHolder(view)

    }



    override fun getItemCount(): Int = rankItems.size

    override fun onBindViewHolder(holder: HomeTabRankViewHolder, position: Int) {
        when {
            rankItems[position].place_category == "역사 문화" -> holder.place_category.setBackgroundColor(Color.parseColor("#fb8b20"))
            rankItems[position].place_category == "도시 건축" -> holder.place_category.setBackgroundColor(Color.parseColor("#549b0e"))
            rankItems[position].place_category == "과학 경제" -> holder.place_category.setBackgroundColor(Color.parseColor("#5ba2f6"))
        }

        //textviewbackground
        holder.placename.text = rankItems[position].place_name

        when (position) {
            0 -> {
                holder.placerank.setBackgroundResource(R.drawable.ranking_1)
                holder.placerank.text = ""
            }
            1 -> {
                holder.placerank.setBackgroundResource(R.drawable.ranking_2)
                holder.placerank.text = ""
            }
            2 -> {
                holder.placerank.setBackgroundResource(R.drawable.ranking_3)
                holder.placerank.text = ""
            }
            else -> {
                holder.placerank.setBackgroundColor(Color.parseColor("#00000000"))
                holder.placerank.text = (position+1).toString()
            }
        }
    }
}