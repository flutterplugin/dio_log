import 'package:flutter/material.dart';

import 'home_page.dart';
import 'http_utils.dart';

void main() {
  initHttp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo of dio_log',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Demo of dio_log'),
    );
  }
}
