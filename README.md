# MercadoPago Mobile Checkout Integration

![Screenshot iOS](https://caramel-static-images.s3.amazonaws.com/mercado_pago.png)

## 🌟 Features

- MercadoPago's SDK integrated, supporting [Mobile Checkout](https://www.mercadopago.com.ar/developers/es/guides/payments/mobile-checkout/introduction/)
- Easy to install
- Easy to integrate
- PCI compliance
- Android Support
- IOS Support

## 📲 How to Install

To use this plugin, add `mercado_pago_integration` as a dependency in your pubspec.yaml file.

## 🐒 How to use

Only **4** steps needed to create a basic checkout using `mercado_pago_integration`:

### 1 - Import into the project

```dart
import 'package:mercado_pago_integration/mercado_pago_integration.dart';
```

### 2 - Set your  `PublicKey`  and  `AccessToken`

In order to start a new mobile checkout, you need to have a [Public_Key & AccessToken](https://www.mercadopago.com.ar/developers/es/guides/faqs/credentials/)
  
### 3 - Create your checkout preference configuration

See the example below, if you want more information, [here](https://www.mercadopago.com.ar/developers/es/guides/payments/web-payment-checkout/integration/#editor_1596138256) is the official documentation.

```dart
final Map<String, Object> preferenceMap = {
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
```

### 4 - Start Mobile Checkout

```dart
MercadoPagoIntegration.startCheckout(
    publicKey: "[Your_Mercado_Pago_Public_Key]",
    preference: preferenceMap,
    accessToken: "[Your_Mercado_Pago_Access_Token]",
);
```

### IOS Integration

#### 1 - Update `Podfile`

```swift
platform :ios, '10.0'
```

#### 2 - Update `AppDelegate.swift`

```swift
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    var navigationController: UINavigationController?;

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
        self.navigationController = UINavigationController(rootViewController: flutterViewController);
        self.window = UIWindow(frame: UIScreen.main.bounds);
        self.window.rootViewController = self.navigationController;
        self.window.makeKeyAndVisible();
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
```

#### Responses

To Be Defined

### 📋 Supported OS & SDK Versions

- iOS 10.0 
- Addroid minSdk 19

### 🔮 Project Example

This project includes an example project using Mercado Pago Integration, checkout `example` folder. In case you need support contact the Caramel Point Developers Site.

## 👨🏻‍💻 Author

Caramel Point

## 👮🏻 License

``` txt

MIT License

Copyright (c) CaramelPoint Inc

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
