package com.caramelpoint.mercado_pago_integration

import android.app.Activity
import android.content.Intent
import com.google.gson.Gson
import com.mercadopago.android.px.core.MercadoPagoCheckout
import com.mercadopago.android.px.model.Payment
import com.mercadopago.android.px.model.exceptions.MercadoPagoError
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class MercadoPagoHelper : PluginRegistry.ActivityResultListener {

    private var requestCode = 7717

    constructor(activity: ActivityPluginBinding) {
        this.activityPluginBinding = activity
        activity.addActivityResultListener(this);
    }

    private var activityPluginBinding: ActivityPluginBinding
    var result: MethodChannel.Result? = null

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        println("ACTIVITY RESULT")
        println(requestCode.toString())
        if (requestCode == this.requestCode) {
            onMercadoPagoResult(resultCode, data)
        }
        return false
    }

    fun getActivity(): Activity {
        return activityPluginBinding.activity
    }

    private fun onMercadoPagoResult(resultCode: Int, data: Intent?) {
        var response = HashMap<String, Any>()
        response["resultCode"] = "$resultCode"
        if (isSuccessResult(resultCode)) {
            println("SUCCESS")
            response["payment"] = getPaymentFromData(data)
            println( response["payment"])
        } else if (isErrorResult(resultCode, data)) {
            println("ERROR")
            response["error"] = getErrorFromData(data)
            println( response["error"])
        }
        var json = Gson().toJson(response);
        println("JSON RESULT")
        println(json)
        this.result?.success(json)
    }

    private fun isErrorResult(resultCode: Int, data: Intent?) =
            resultCode == Activity.RESULT_CANCELED && data != null && data.extras != null

    private fun isSuccessResult(resultCode: Int) =
            resultCode == MercadoPagoCheckout.PAYMENT_RESULT_CODE

    private fun getPaymentFromData(data: Intent?): Payment {
        return data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_PAYMENT_RESULT) as Payment
    }

    private fun getErrorFromData(data: Intent?): MercadoPagoError {
        return data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_ERROR) as MercadoPagoError
    }
}