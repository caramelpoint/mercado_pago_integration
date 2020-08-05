import 'package:flutter/material.dart';
import 'package:mercado_pago_integration/core/failures.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';
import 'package:mercado_pago_integration/models/payment.dart';

final Map<String, Object> preference = {
  'items': [
    {
      'title': 'Test Product',
      'description': 'Description',
      'quantity': 3,
      'currency_id': 'ARS',
      'unit_price': 1500,
    }
  ],
  'payer': {'name': 'Buyer G.', 'email': 'test@gmail.com'},
};
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Mercado Pago Integration Example'),
        ),
        body: Center(
          child: RaisedButton(
            onPressed: () async {
              (await MercadoPagoIntegration.startCheckout(
                publicKey: "PUBLIC_KEY",
                preference: preference,
                accessToken: "ACCESS_TOKEN",
              ))
                  .fold((Failure failure) {
                debugPrint('Failure => ${failure.message}');
              }, (Payment payment) {
                debugPrint('Payment => ${payment.id}');
              });
            },
            child: Text('Test Integration'),
          ),
        ),
      ),
    );
  }
}
