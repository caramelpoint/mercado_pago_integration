import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MercadoPagoIntegration {
  static const MethodChannel _channel =
      const MethodChannel('mercado_pago_integration');

  static Future<dynamic> startCheckout({
    @required String publicKey,
    @required String checkoutPreferenceId,
  }) async {
    return await _channel.invokeMethod('startCheckout', {
      'publicKey': publicKey,
      'checkoutPreferenceId': checkoutPreferenceId,
    });
  }
}
