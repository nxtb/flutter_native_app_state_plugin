import 'package:flutter/material.dart';

import 'package:flutter_native_app_state/flutter_native_app_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    FlutterNativeAppState.observeAppState.listen((event) {
      print('iOS App State     : $event');
      print('WidgetsBinding now: ${WidgetsBinding.instance.lifecycleState}');
      print('framesEnabled now : ${WidgetsBinding.instance.framesEnabled}');
    });
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('WidgetsBinding updated: $state');
    print('framesEnabled after LF: ${WidgetsBinding.instance.framesEnabled}');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
      ),
    );
  }
}
