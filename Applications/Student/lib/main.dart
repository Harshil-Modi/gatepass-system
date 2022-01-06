import 'package:flutter/material.dart';
import 'package:gatepassStudent/screens/wrapper.dart';
import 'package:gatepassStudent/shared/const.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
// removes debug banner, not necessary to put
      debugShowCheckedModeBanner: false,

      title: title,
      home: Wrapper(),
    );
  }
}
