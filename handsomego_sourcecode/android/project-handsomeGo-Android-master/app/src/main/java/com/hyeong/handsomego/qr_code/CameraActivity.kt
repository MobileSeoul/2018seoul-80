package com.hyeong.handsomego.qr_code

import android.app.Activity
import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.Toast
import com.google.zxing.integration.android.IntentIntegrator
import com.google.zxing.integration.android.IntentResult
import com.hyeong.handsomego.Idx
import com.hyeong.handsomego.QrFlag
import com.hyeong.handsomego.R
import com.hyeong.handsomego.after_stamp.SimpleInfoActivity
import com.journeyapps.barcodescanner.DecoratedBarcodeView
import com.journeyapps.barcodescanner.CaptureManager



class CameraActivity : AppCompatActivity(){

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val integrator = IntentIntegrator(this).setBeepEnabled(false)
        integrator.captureActivity = CustomScannerActivity::class.java
        integrator.initiateScan()
    }

    override fun onResume() {
        super.onResume()
        // CustomScannerActivity 종료시 CameraActivity도 종료
        if(QrFlag.back) {
            QrFlag.back = false
            this.finish()
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if(resultCode == Activity.RESULT_OK) {
            try {
                val result: IntentResult = IntentIntegrator.parseActivityResult(requestCode, resultCode, data)
                Idx.place_id = result.contents.toInt()
                QrFlag.back = true
                startActivity(Intent(applicationContext, SimpleInfoActivity::class.java))
            }catch (e : Exception){
                Toast.makeText(this,"잘못된 QR 코드입니다.",Toast.LENGTH_SHORT).show()
                this.finish()
            }
        }
    }
}
