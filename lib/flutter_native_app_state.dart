import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNativeAppState {
  static const MethodChannel _channel =
      const MethodChannel('flutter_native_app_state');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
