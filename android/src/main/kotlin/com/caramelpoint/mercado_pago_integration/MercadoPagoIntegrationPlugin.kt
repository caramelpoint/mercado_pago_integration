package com.caramelpoint.mercado_pago_integration

import android.app.Activity
import androidx.annotation.NonNull
import android.content.Context
import android.content.Intent
import com.google.gson.Gson
import com.mercadopago.android.px.core.MercadoPagoCheckout
import com.mercadopago.android.px.model.Payment
import com.mercadopago.android.px.model.exceptions.MercadoPagoError
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** MercadoPagoIntegrationPlugin */
public class MercadoPagoIntegrationPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  private var applicationContext: Context? = null
  private var channel : MethodChannel? = null
  private var activityPluginBinding: ActivityPluginBinding? = null
  private var result: Result? = null
  private var requestCode = 7717

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.applicationContext = flutterPluginBinding.applicationContext
    this.channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mercado_pago_integration")
    this.channel?.setMethodCallHandler(this)
  }



  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.activityPluginBinding = binding
    this.activityPluginBinding?.addActivityResultListener(this)
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    this.activityPluginBinding = binding
    this.activityPluginBinding?.addActivityResultListener(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    this.applicationContext = null
    this.channel?.setMethodCallHandler(null)
    this.channel = null
  }

  override fun onDetachedFromActivityForConfigChanges() {
    this.activityPluginBinding?.removeActivityResultListener(this)
    this.activityPluginBinding = null
  }

  override fun onDetachedFromActivity() {
    this.activityPluginBinding?.removeActivityResultListener(this)
    this.activityPluginBinding = null
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "startCheckout" -> {
        startCheckout(call, result)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun startCheckout(call: MethodCall, result: MethodChannel.Result) {
    val publicKey: String = call.argument("publicKey")!!
    val checkoutPreferenceId: String = call.argument("checkoutPreferenceId")!!
    this.result = result
    MercadoPagoCheckout.Builder(
            publicKey,
            checkoutPreferenceId)
            .build()
            .startPayment(this.activityPluginBinding!!.activity, requestCode)
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    if (requestCode == this.requestCode) {
      onMercadoPagoResult(resultCode, data)
    }
    return false
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
