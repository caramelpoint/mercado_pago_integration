# MercadoPago Mobile Checkout Integration

- The flutter plugin with MercadoPago's sdk integrated, in order to suppor [Mobile Checkout](https://www.mercadopago.com.ar/developers/es/guides/payments/mobile-checkout/introduction/)
- It is a specialized package that includes platform-specific implementation code for Android and/or iOS.

## Usage

To use this plugin, add `mercado_pago_integration` as a dependency in your pubspec.yaml file.

### Getting Started

---

    import 'package:mercado_pago_integration/mercado_pago_integration.dart';

### Mobile Checkout

- In order to start a new mobile checkout you need to have a [Public_Key](https://www.mercadopago.com.ar/developers/es/guides/faqs/credentials/)
- Besides, you need to create a `CheckoutPreferenceId` usign the [Official documentation](https://www.mercadopago.com.co/developers/es/guides/payments/mobile-checkout/receive-payments/) or you can use this [Package](https://pub.dev/packages/mercadopago_sdk) from the comunity
- After that, you only have to invoke the next line

---

    MercadoPagoIntegration.startCheckout(publicKey: "",checkoutPreferenceId: "");

#### Responses

To Be Defined
