package com.hyeong.handsomego.qr_code

import android.content.Intent
import android.os.Bundle
import android.support.v4.app.Fragment
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import com.google.zxing.integration.android.IntentIntegrator
import com.google.zxing.integration.android.IntentResult
import com.hyeong.handsomego.R

/**
 * Created by HYEON on 2018-09-03.
 */
class QRcodeTabFragment : Fragment() {
    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        val v = inflater.inflate(R.layout.fragment_qrcodetab,container,false)
        startActivity(Intent(context,CameraActivity::class.java))
        return v
    }
}