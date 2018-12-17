package com.hyeong.handsomego.applicationController


import com.hyeong.handsomego.post.*
import com.hyeong.handsomego.get.*
import com.hyeong.handsomego.put.*
import okhttp3.RequestBody
import retrofit2.Call
import retrofit2.http.*

/**
 * Created by HYEON on 2018-09-19.
 */
interface NetworkService {
    // 로그인
    @POST("login")
    fun postLogin(@Body loginData : PostLoginData) : Call<PostLoginResponse>

    //특정 장소 정보 불러오기
    @GET("places/{place_id}")
    fun getSpaceInfo(@Path("place_id") place_id : Int) : Call<GetSpaceResponse>

    // 순위 조회
    @GET("ranks")
    fun getRankReview() : Call<GetRankReviewResponse>

    // 댓글 작성
    @POST("comments")
    fun postReview(@Header("Authorization") token : String, @Body reviewData : PostReviewResponseData) : Call<PostReviewResponse>

    // 댓글 삭제
    @DELETE("comments/{comment_id}")
    fun delReview(@Header("Authorization") token : String, @Path("comment_id") idx : Int) : Call<PostReviewResponse>    // 같은 response 형식이므로 이용

    // 장소의 댓글들 조회
    @GET("places/{place_id}/comments")          // 토큰 없을 시 게스트 로그인
    fun getReview(@Header("Authorization") token : String?, @Path("place_id") idx : Int) : Call<GetReviewResponse>

   // 댓글 상세 조회
    @GET("comments/{comment_idx}")
    fun getMoreReview(@Path("comment_idx") idx : Int):Call<GetMoreReviewResponse>

    // 장소 세부 조회
    @GET("places/{place_id}")
    fun getPlaceInfo(@Path("place_id") idx : Int):Call<GetPlaceInfoResponse>

    // 장소의 스탬프 조회
    @GET("stamps/{place_id}")
    fun getStampPlace(@Header("Authorization") token : String, @Path("place_id") idx : Int) : Call<GetStampPlaceResponse>

    // 장소의 스탬프 적립
    @POST("stamps/{place_id}")
    fun postStampPlace(@Header("Authorization") token : String, @Path("place_id") idx : Int) : Call<PostStampPlaceResponse>

    // 마이페이지 조회
    @GET("mypage")
    fun getMypage(@Header("Authorization") token : String) : Call<GetMypageResponse>

    // 마이페이지 수정
    @PUT("mypage")
    fun putMypage(@Header("Authorization") token : String, @Body edit : PutEditResponseData) : Call<PutEditResponse>

    // 스탬프 조회
    @GET("stamps")
    fun getStampInfo(@Header("Authorization") token : String) : Call<GetStampInfoResponse>
}