import Flutter
import UIKit

public class AppStateHandler : NSObject, FlutterStreamHandler {
    private var latestValue: UIApplication.State
    private var eventSink: FlutterEventSink? = nil
    
    init(_ initialValue: UIApplication.State) {
        latestValue = initialValue
    }
    
    public func update(_ state: UIApplication.State) {
        latestValue = state
        pushLatest()
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        pushLatest()
        
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        
        return nil
    }
    
    private func pushLatest() {
        eventSink?(latestValue.rawValue)
    }
}

public class SwiftFlutterNativeAppStatePlugin: NSObject, FlutterPlugin {
    let appStateHandler = AppStateHandler(UIApplication.shared.applicationState)
    
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let instance = SwiftFlutterNativeAppStatePlugin()

    let channel = FlutterMethodChannel(name: "flutter_native_app_state", binaryMessenger: registrar.messenger())
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    // Setup Event channel
    let eventChannel = FlutterEventChannel(name: "flutter_native_app_state/events", binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(instance.appStateHandler)
    instance.appStateHandler.update(UIApplication.shared.applicationState)
    
    // Ensure the plugin receives Application State events.
    registrar.addApplicationDelegate(instance)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}

extension SwiftFlutterNativeAppStatePlugin {
    public func applicationDidEnterBackground(_ application: UIApplication) {
        appStateHandler.update(UIApplication.shared.applicationState)
    }

    public func applicationWillEnterForeground(_ application: UIApplication) {
        appStateHandler.update(UIApplication.shared.applicationState)
    }

    public func applicationDidBecomeActive(_ application: UIApplication) {
        appStateHandler.update(UIApplication.shared.applicationState)
    }

    public func applicationWillResignActive(_ application: UIApplication) {
        appStateHandler.update(UIApplication.shared.applicationState)
    }
}
