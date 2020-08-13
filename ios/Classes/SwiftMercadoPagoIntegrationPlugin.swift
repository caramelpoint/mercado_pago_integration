import Flutter
import UIKit
import MercadoPagoSDK

public class SwiftMercadoPagoIntegrationPlugin: NSObject, FlutterPlugin, PXLifeCycleProtocol
{
    private var checkout: MercadoPagoCheckout?
    var flutterCallbackResult: FlutterResult? = nil
    var rootViewController: UIViewController? = nil
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "mercado_pago_integration", binaryMessenger: registrar.messenger())
        let instance = SwiftMercadoPagoIntegrationPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if(call.method == "startCheckout"){
            startMobileCheckout(result, call)
        }
    }
    
    func startMobileCheckout(_ result: @escaping FlutterResult, _ call: FlutterMethodCall) {
        self.flutterCallbackResult = result
        let arguments = call.arguments as! NSDictionary
        let publicKey = arguments["publicKey"] as! String
        let checkoutPreferenceId = arguments["checkoutPreferenceId"] as! String
        // 1) Create Builder with your publicKey and preferenceId.
        let builder = MercadoPagoCheckoutBuilder(publicKey: publicKey, preferenceId: checkoutPreferenceId).setLanguage("es")
        // 2) Create Checkout reference
        checkout = MercadoPagoCheckout(builder: builder)
        // 3) Start with your navigation controller.
        rootViewController = UIApplication.shared.keyWindow?.rootViewController
        
        if (rootViewController is UINavigationController) {
            checkout?.start(navigationController: rootViewController as! UINavigationController, lifeCycleProtocol: self)
        }
        else {
            let navigationController:UINavigationController! = UINavigationController(rootViewController:rootViewController!)
            checkout?.start(navigationController: navigationController, lifeCycleProtocol: self)
        }
    }
    
    
    public func finishCheckout() -> ((PXResult?) -> Void)? {
        return ({ (_ payment: PXResult?) in
            let mapValues:NSMutableDictionary = NSMutableDictionary()
            let mapValuesResponse:NSMutableDictionary = NSMutableDictionary()
            mapValues.setValue(payment?.getStatus(), forKey: "status")
            mapValues.setValue(payment?.getPaymentId(), forKey:"paymentId")
            mapValues.setValue(payment?.getStatusDetail(), forKey: "statusDetail")
            let paymentData = try! JSONSerialization.data(withJSONObject: mapValues)
            let paymentJsonString = NSString(data: paymentData, encoding: String.Encoding.utf8.rawValue)! as String
            mapValuesResponse.setValue(paymentJsonString, forKey:"payment")
            mapValuesResponse.setValue("200", forKey:"resultCode")
            mapValuesResponse.setValue("", forKey:"error")
            let jsonData = try! JSONSerialization.data(withJSONObject: mapValuesResponse)
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            self.flutterCallbackResult!(jsonString)
            (self.rootViewController as! UINavigationController).popToRootViewController(animated: true)
        })
    }
    
    public func cancelCheckout() -> (() -> Void)? {
        let mapValuesResponse:NSMutableDictionary = NSMutableDictionary()
        mapValuesResponse.setValue("Canceled", forKey:"error")
        mapValuesResponse.setValue("404", forKey:"resultCode")
        let jsonData = try! JSONSerialization.data(withJSONObject: mapValuesResponse)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        self.flutterCallbackResult!(jsonString)
        return nil
    }
    
}

extension FlutterViewController {
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

