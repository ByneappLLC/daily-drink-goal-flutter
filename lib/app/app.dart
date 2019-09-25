import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: FlutterConfig.get('APP_NAME'),
      home: Container(),
    );
  }
}
