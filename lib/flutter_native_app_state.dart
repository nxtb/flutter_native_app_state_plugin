import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNativeAppState {
  static const MethodChannel _channel =
      const MethodChannel('flutter_native_app_state');

  static const EventChannel _eventChannel =
      const EventChannel('flutter_native_app_state/events');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Stream<int> _appStateStream;
  static Stream<int> get observeAppState {
    return _appStateStream ??=
        _eventChannel.receiveBroadcastStream().map<int>((event) => event);
  }
}
