package com.caramelpoint.mercado_pago_integration

import android.app.Activity
import android.app.Activity.RESULT_CANCELED
import android.content.Intent
import com.google.gson.Gson
import com.mercadopago.android.px.core.MercadoPagoCheckout
import com.mercadopago.android.px.model.Payment
import com.mercadopago.android.px.model.exceptions.MercadoPagoError
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry


class MercadoPagoHelper(activity: ActivityPluginBinding) : PluginRegistry.ActivityResultListener {

    private var requestCode = 7717

    private var activityPluginBinding: ActivityPluginBinding = activity
    var result: MethodChannel.Result? = null

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        if (requestCode == this.requestCode) {
            onMercadoPagoResult(resultCode, data)
        }
        return false
    }

    fun getActivity(): Activity {
        return activityPluginBinding.activity
    }

    private fun onMercadoPagoResult(resultCode: Int, data: Intent?) {
        val response = HashMap<String, Any>()
        response["resultCode"] = "$resultCode"
        when {
            isSuccessResult(resultCode) -> {
                response["payment"] = getPaymentFromData(data)
            }
            isErrorResult(resultCode, data) -> {
                response["error"] = getErrorFromData(data).message
            }
            else -> {
                response["error"] = "Canceled"
            }
        }
        this.result?.success(Gson().toJson(response))
    }

    private fun isErrorResult(resultCode: Int, data: Intent?) =
            resultCode == RESULT_CANCELED && data != null && data.extras != null

    private fun isSuccessResult(resultCode: Int) =
            resultCode == MercadoPagoCheckout.PAYMENT_RESULT_CODE

    private fun getPaymentFromData(data: Intent?): Payment {
        return data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_PAYMENT_RESULT) as Payment
    }

    private fun getErrorFromData(data: Intent?): MercadoPagoError {
        return data!!.getSerializableExtra(MercadoPagoCheckout.EXTRA_ERROR) as MercadoPagoError
    }

    init {
        activity.addActivityResultListener(this)
    }
}