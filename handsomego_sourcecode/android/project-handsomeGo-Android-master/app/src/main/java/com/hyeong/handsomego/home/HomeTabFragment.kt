package com.hyeong.handsomego.home

import android.os.Bundle
import android.support.v4.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import com.hyeong.handsomego.R
import kotlinx.android.synthetic.main.fragment_hometab.*
import kotlinx.android.synthetic.main.fragment_hometab.view.*

/**
 * Created by HYEON on 2018-09-03.
 */
class HomeTabFragment : Fragment(), View.OnClickListener {


    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val v = inflater.inflate(R.layout.fragment_hometab, container, false)


        addFragment(HomeTabMapFragment())
        v.home_map_view.visibility = View.VISIBLE

        v.map_btn.setOnClickListener(this)
        v.rank_btn.setOnClickListener(this)


        return v

    }

    override fun onClick(v: View?) {
        when (v) {
            map_btn -> {
                replaceFragment(HomeTabMapFragment())
                home_map_view.visibility = View.VISIBLE
                home_rank_view.visibility = View.INVISIBLE
            }
            rank_btn -> {
                replaceFragment(HomeTabRankFragment())
                home_map_view.visibility = View.INVISIBLE
                home_rank_view.visibility = View.VISIBLE
            }
        }
    }

    //Fragment 붙이는 함수
    fun addFragment(fragment: Fragment): Unit {
        val fm = activity!!.supportFragmentManager
        val transaction = fm.beginTransaction()
        transaction.add(R.id.home_frame, fragment)
        transaction.commit()
    }

    //Fragment 교체
    fun replaceFragment(fragment: android.support.v4.app.Fragment): Unit {
        val fm = activity!!.supportFragmentManager
        val transaction = fm.beginTransaction()
        transaction.replace(R.id.home_frame, fragment)
        transaction.commit()
    }
}