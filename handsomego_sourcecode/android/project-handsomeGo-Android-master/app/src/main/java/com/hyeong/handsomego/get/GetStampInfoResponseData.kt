package com.hyeong.handsomego.get

/**
 * Created by HYEON on 2018-09-19.
 */
data class GetStampInfoResponseData (
        var status : String,
        var place : ArrayList<GetStampInfoResponseData2>
)