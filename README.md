# Mercado Pago Integration

The flutter plugin with MercadoPago's sdk integrated, in order to suppor [Mobile Checkout](https://www.mercadopago.com.ar/developers/es/guides/payments/mobile-checkout/introduction/)
It is a specialized package that includes platform-specific implementation code for Android and/or iOS.

## Getting Started

Just import the package

```sh
  import 'package:mercado_pago_integration/mercado_pago_integration.dart';
```

### Start a new checkout process

```sh
  MercadoPagoIntegration.startCheckout(publicKey: "",checkoutPreferenceId: "");
```
