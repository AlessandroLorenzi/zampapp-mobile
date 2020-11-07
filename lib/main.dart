import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zampapp_mobile/screens/loginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'ZampApp';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: LoginScreen(),
    );
  }
}
