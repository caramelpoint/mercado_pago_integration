package com.caramelpoint.mercado_pago_integration

import android.app.Activity
import androidx.annotation.NonNull;
import com.mercadopago.android.px.core.MercadoPagoCheckout

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** MercadoPagoIntegrationPlugin */
public class MercadoPagoIntegrationPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var mercadoPagoHelper: MercadoPagoHelper
  private var requestCode = 7717

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    this.channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mercado_pago_integration")
    this.channel.setMethodCallHandler(this);
  }


  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    this.mercadoPagoHelper = MercadoPagoHelper(binding)
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivityForConfigChanges() {
    TODO("Not yet implemented")
  }

  override fun onDetachedFromActivity() {
    TODO("Not yet implemented")
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

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    this.channel.setMethodCallHandler(null)
  }


  private fun startCheckout(call: MethodCall, result: MethodChannel.Result) {
    val publicKey: String = call.argument("publicKey")!!
    val checkoutPreferenceId: String = call.argument("checkoutPreferenceId")!!
    this.mercadoPagoHelper.result = result
    MercadoPagoCheckout.Builder(
            publicKey,
            checkoutPreferenceId)
            .build()
            .startPayment(
                    mercadoPagoHelper.getActivity(),
                    requestCode)
  }
}
