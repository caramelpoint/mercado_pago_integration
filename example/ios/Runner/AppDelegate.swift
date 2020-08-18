import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var navigationController: UINavigationController?;
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
        
        GeneratedPluginRegistrant.register(with: self)
        
        self.navigationController = UINavigationController(rootViewController: flutterViewController)
        self.navigationController?.isNavigationBarHidden = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.navigationController
        self.window?.makeKeyAndVisible()

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
}

class CustomFlutterViewController:FlutterViewController {
  
  override open func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      self.navigationController?.isNavigationBarHidden = true
  }
  
  override open func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      self.navigationController?.isNavigationBarHidden = false
  }
}

