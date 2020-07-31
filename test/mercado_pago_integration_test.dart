import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';

final Map<String, Object> preference = {
  'items': [
    {
      'title': 'Product',
      'description': 'Description',
      'quantity': 3,
      'currency_id': 'ARS',
      'unit_price': 1500,
    }
  ],
  'payer': {'name': 'Buyer G.', 'email': 'test@test.com'},
};
void main() {
  const MethodChannel channel = MethodChannel('mercado_pago_integration');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'Starting';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(
        await MercadoPagoIntegration.startCheckout(
          publicKey: "",
          accessToken: "",
          preference: preference,
        ),
        'Starting');
  });
}
