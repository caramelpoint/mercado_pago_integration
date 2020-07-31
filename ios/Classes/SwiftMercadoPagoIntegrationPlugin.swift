import Flutter
import UIKit
import MercadoPagoSDK

public class SwiftMercadoPagoIntegrationPlugin: NSObject, FlutterPlugin, PXLifeCycleProtocol
{
    private var checkout: MercadoPagoCheckout?
    var flutterCallbackResult: FlutterResult? = nil
    
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
        let rootViewController:UIViewController! = UIApplication.shared.keyWindow?.rootViewController
        
        if (rootViewController is UINavigationController) {
            checkout?.start(navigationController: rootViewController as! UINavigationController, lifeCycleProtocol: self)
        }
        else {
            let navigationController:UINavigationController! = UINavigationController(rootViewController:rootViewController)
            checkout?.start(navigationController: navigationController, lifeCycleProtocol: self)
        }
    }
    
    
    public func finishCheckout() -> ((PXResult?) -> Void)? {
        let mapValues:NSMutableDictionary = NSMutableDictionary()
        mapValues.setValue("status", forKey: "status")
        mapValues.setValue("paymentId", forKey:"paymentId")
        mapValues.setValue("statusDetail", forKey: "statusDetail")
        let jsonData = try! JSONSerialization.data(withJSONObject: mapValues)
        let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
        self.flutterCallbackResult!(jsonString)
        return nil
    }
    
    public func cancelCheckout() -> (() -> Void)? {
        self.flutterCallbackResult!("cancelCheckout")
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

