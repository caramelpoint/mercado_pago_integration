import 'package:flutter/material.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';

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
                      publicKey: "TEST-6e834519-997d-4a19-893e-30b6640ac335",
                      checkoutPreferenceId:
                          "582487861-d0e6d475-4b97-4ed8-a629-a5d2529ea46f");
              debugPrint('RESULTADO$platformVersion');
            },
            child: Text('Test Integration'),
          ),
        ),
      ),
    );
  }
}
