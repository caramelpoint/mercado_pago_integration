import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mercado_pago_integration/mercado_pago_integration.dart';

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
            publicKey: "", checkoutPreferenceId: ""),
        'Starting');
  });
}
