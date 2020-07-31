import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';

MPRestClient _restClient = MPRestClient();

class MercadoPagoIntegration {
  static const MethodChannel _channel =
      const MethodChannel('mercado_pago_integration');

  static Future<dynamic> startCheckout({
    @required String publicKey,
    @required Map<String, dynamic> preference,
    @required String accessToken,
  }) async {
    try {
      Map<String, dynamic> response =
          await _createNewPreference(preference, accessToken);
      if (response != null) {
        final String checkoutPreferenceId =
            response['response']['id'].toString();
        final String mpResult = await _channel.invokeMethod('startCheckout', {
          'publicKey': publicKey,
          'checkoutPreferenceId': checkoutPreferenceId,
        });
        debugPrint('RESULTADO $mpResult');
      } else {
        // ignore: todo
        //TODO (todo): handle error
      }
    } catch (e) {
      // ignore: todo
      //TODO (todo): handle error
    }
  }

  static Future<Map<String, dynamic>> _createNewPreference(
    Map<String, dynamic> preference,
    String accessToken,
  ) async {
    return _restClient.post(
      '/checkout/preferences',
      params: {
        'access_token': accessToken,
      },
      data: preference,
    );
  }
}
