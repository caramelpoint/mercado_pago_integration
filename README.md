# MercadoPago Mobile Checkout Integration

## 🌟 Features

- [x] MercadoPago's sdk integrated, in order to suppor [Mobile Checkout](https://www.mercadopago.com.ar/developers/es/guides/payments/mobile-checkout/introduction/)
- [x] Easy to install
- [x] Easy to integrate
- [x] PCI compliance
- [x] Android Support
- [x] IOS Support

## 📲 How to Install

To use this plugin, add `mercado_pago_integration` as a dependency in your pubspec.yaml file.

## 🐒 How to use

Only **3** steps needed to create a basic checkout using `mercado_pago_integration`:

### 1 - Import into project

```dart
import 'package:mercado_pago_integration/mercado_pago_integration.dart';
```

### 2 - Set your  `PublicKey`  and  `PreferenceId` 

- In order to start a new mobile checkout you need to have a [Public_Key](https://www.mercadopago.com.ar/developers/es/guides/faqs/credentials/)
- Besides, you need to create a `CheckoutPreferenceId` usign the [Official documentation](https://www.mercadopago.com.co/developers/es/guides/payments/mobile-checkout/receive-payments/) or you can use this [Package](https://pub.dev/packages/mercadopago_sdk) from the comunity

### 3 - Start Mobile Checkout

```dart
    MercadoPagoIntegration.startCheckout(publicKey: "",checkoutPreferenceId: "");
```

#### Responses

To Be Defined
