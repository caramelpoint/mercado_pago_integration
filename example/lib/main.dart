import 'package:flutter/material.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';

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
              String platformVersion =
                  await MercadoPagoIntegration.startCheckout(
                publicKey: "[Your_Mercado_Pago_Public_Key]",
                preference: preference,
                accessToken: "[Your_Mercado_Pago_Access_Token]",
              );
              debugPrint('RESULTADO$platformVersion');
            },
            child: Text('Test Integration'),
          ),
        ),
      ),
    );
  }
}
