import 'dart:async';

import 'package:flutter/services.dart';

class FlutterNativeAppState {
  static const EventChannel _eventChannel =
      const EventChannel('flutter_native_app_state/events');

  static Stream<int>? _appStateStream;
  static Stream<int> get observeAppState {
    return _appStateStream ??=
        _eventChannel.receiveBroadcastStream().map<int>((event) => event);
  }
}
