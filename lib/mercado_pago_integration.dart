import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mercadopago_sdk/mercadopago_sdk.dart';

import 'core/failures.dart';
import 'models/payment.dart';
import 'models/result.dart';

MPRestClient _restClient = MPRestClient();

class MercadoPagoIntegration {
  static const MethodChannel _channel = const MethodChannel('mercado_pago_integration');

  static Future<Either<Failure, Payment>> startCheckout({
    @required String publicKey,
    @required Map<String, dynamic> preference,
    @required String accessToken,
  }) async {
    try {
      assert(publicKey != null);
      assert(accessToken != null);
      assert(preference != null);
      Map<String, dynamic> response = await _createNewPreference(preference, accessToken);
      if (response != null && response['status'] == 201) {
        final String checkoutPreferenceId = response['response']['id'].toString();
        final String mpResult = await _channel.invokeMethod('startCheckout', {
          'publicKey': publicKey,
          'checkoutPreferenceId': checkoutPreferenceId,
        });
        Result result;
        try {
          result = Result.fromJson(jsonDecode(mpResult) as Map<String, dynamic>);
          if (result.error != null && result.error.isNotEmpty) {
            return Left(UserCanceledFailure(message: result.error));
          } else {
            return Right(result.payment);
          }
        } catch (er) {
          debugPrint(er);
          return Left(UserCanceledFailure(message: 'Wrong Payment information, please review it'));
        }
      } else {
        return Left(CreatePreferenceFailure(message: 'Wrong Preferences, please review it.'));
      }
    } catch (e) {
      return Left(CreatePreferenceFailure(message: '${e?.code} -> ${e?.message}'));
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
