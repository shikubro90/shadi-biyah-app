import UIKit
import Flutter
import flutter_downloader
import SystemConfiguration

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private static let VPN_CHANNEL = "method.com/vpn"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

        // Set up VPN channel
        let vpnChannel = FlutterMethodChannel(
            name: AppDelegate.VPN_CHANNEL,
            binaryMessenger: controller.binaryMessenger
        )

        vpnChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "isVpnConnected" {
                // Use async to make sure the closure is marked as escaping
                DispatchQueue.main.async {
                    result(VPNManager.isVpnConnected())
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        // Set up other plugins
        registerPlugins(registry: self)

        // Continue with FlutterDownloaderPlugin registration
        FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func registerPlugins(registry: FlutterPluginRegistry) {
        if !registry.hasPlugin("FlutterDownloaderPlugin") {
            FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
        }
        // Add more plugin registrations here as needed
    }
}

// Add the VPNManager class definition here if not in a separate file
class VPNManager {
    static func isVpnConnected() -> Bool {
        // Implementation for checking VPN connection
        // ...
        return false
    }
}
