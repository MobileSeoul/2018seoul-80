package com.hyeong.handsomego.qr_code

import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.view.View
import com.hyeong.handsomego.R
import com.journeyapps.barcodescanner.CaptureManager
import com.journeyapps.barcodescanner.DecoratedBarcodeView

class CustomScannerActivity : AppCompatActivity(){
    lateinit var capture : CaptureManager
    lateinit var back : BackPressCloseHandler
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_custom_scanner)

        back = BackPressCloseHandler(this)

        val barcodeScannerView = findViewById<View>(R.id.zxing_barcode_scanner2) as DecoratedBarcodeView
        capture = CaptureManager(this, barcodeScannerView)
        capture.initializeFromIntent(intent, savedInstanceState)
        capture.decode()
    }

    override fun onResume() {
        super.onResume()
        capture.onResume()
    }

    override fun onPause() {
        super.onPause()
        capture.onPause()
    }

    override fun onDestroy() {
        super.onDestroy()
        capture.onDestroy()
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        capture.onSaveInstanceState(outState)
    }

    override fun onBackPressed() {
        back.onBackPressed()
    }
}